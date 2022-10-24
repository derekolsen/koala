const puppeteer = require('puppeteer')
const { PuppeteerScreenRecorder } = require('puppeteer-screen-recorder')
const express = require('express')
const app = express()
const stream = require('stream')
const fs = require('fs')
const toml = require('toml')

const recorderConfig = {
  followNewTab: true,
  fps: 30,
  ffmpeg_Path: '/usr/bin/ffmpeg' || null,
  videoFrame: {
    width: 1920,
    height: 1080,
  },
  videoCrf: 31,
  videoCodec: 'libx264',
  videoPreset: 'fast',
  videoBitrate: 2000,
  aspectRatio: '16:9',
}

let koala
try {
  const data = fs.readFileSync('./config.toml', 'utf-8')
  koala = toml.parse(data)
} catch (err) {
  console.error(err)
}

let passthroughs = {}
for (server in koala.servers) {
  if (!koala.servers[server] || !koala.servers[server].enabled) continue
  (async () => {
    let site = server
    const browser = await puppeteer.launch()
    const page = await browser.newPage()
    const recorder = new PuppeteerScreenRecorder(page, recorderConfig)
    passthroughs = Object.assign({ [site]: new stream.PassThrough() }, passthroughs)
    await recorder.startStream(passthroughs[site])
    await page.goto(koala.servers[site].url)
  })()
}

app.get('/:site', (req, res) => {
  const site = req.params.site
  if (!koala.servers[site] || !koala.servers[site].enabled) {
    res.status(404).send('404')
    return
  }
  passthroughs[site].pipe(res)
})

app.listen(koala.config['port'], () => {
  console.log(`Koala server running on port ${koala.config['port']}`)
})
