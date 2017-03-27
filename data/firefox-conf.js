// http://www.omgubuntu.co.uk/2017/03/force-enable-firefox-52-npapi-support 
pref("plugin.load_flash_only", false);


// https://developer.mozilla.org/en-US/Firefox/Enterprise_deployment
// Disable updater
lockPref("app.update.enabled", false);
// make absolutely sure it is really off
lockPref("app.update.auto", false);
lockPref("app.update.mode", 0);
lockPref("app.update.service.enabled", false);

// Disable Add-ons compatibility checking
clearPref("extensions.lastAppVersion"); 

// Don't show 'know your rights' on first run
pref("browser.rights.3.shown", true);

// Don't show WhatsNew on first run after every update
pref("browser.startup.homepage_override.mstone","ignore");

