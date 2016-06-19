# FAQ

***Can I add custom or premium plugins to be pre-installed with the setup?***
* Yes you can! Just paste the url into the plugins section of `config.yml` like this:
```
plugins_active:
  - adminimize
  - "https://example.com/plugins/mysuperplugin.zip&key=31071988"
  - backwpup
```

***I don't want plugins or themes to be pre-installed, can I skip this part somehow?***
* Sure! You can select what tasks you want to be executed. Simply set `theme: false` and `plugins: false` at the bottom of `config.yml` like this:

  ```
  # SETUP OPTIONS
  ####################################################################
  installation:
    wp: true
    theme: false
    plugins: false
    cleanup: true
      comment: true
      posts: true
      files: true
      themes: true
  ```
