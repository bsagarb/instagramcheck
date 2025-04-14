// server.js
const express = require('express');
const cors = require('cors');
const puppeteer = require('puppeteer-extra');
const StealthPlugin = require('puppeteer-extra-plugin-stealth');

puppeteer.use(StealthPlugin());

const app = express();
app.use(cors());
app.use(express.json());

app.get('/',async(req,res)=>{
    res.send("backend running")
})
app.post('/api/check-instagram', async (req, res) => {
  const { username, password } = req.body;

  try {
    const browser = await puppeteer.launch({ headless: true, args: [ '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-accelerated-2d-canvas',
        '--no-zygote',
        '--single-process',
        '--no-first-run',
        '--disable-gpu',

    ] });
    const page = await browser.newPage();

    await page.goto('https://www.instagram.com/accounts/login/', {
      waitUntil: 'domcontentloaded',
      timeout: 60000,
    });

    await new Promise(resolve => setTimeout(resolve, 5000));

    await page.type('input[name="username"]', username, { delay: 30 });
    await page.type('input[name="password"]', password, { delay: 30 });
    await page.click('button[type="submit"]');

    await new Promise(resolve => setTimeout(resolve, 8000));

    const currentUrl = page.url();

    let status = 'unknown';
    if (currentUrl.includes('/challenge/')) {
      status = 'challenge';
    } else if (await page.$('svg[aria-label="Home"]')) {
      status = 'success';
    } else if (await page.$('#slfErrorAlert')) {
      status = 'invalid';
    }

    await browser.close();
    return res.json({ status });
  } catch (err) {
    console.error('Login error:', err);
    return res.status(500).json({ error: 'Server error during login process' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
