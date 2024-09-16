const { defineConfig } = require('cypress')

module.exports = defineConfig({
  // setupNodeEvents can be defined in either
  // the e2e or component configuration
  e2e: {
    viewportHeight: 720,
    viewportWidth: 1280,
  },
})
