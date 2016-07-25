# Compass

Install Compass and incidentally Sass via `apt-get`. The Ruby role is installed as dependency.

# Gulp

* Install `gulp` globally in the Vagrant box
* Create a prefilled `Gulpfile.js` (if non-existant) with useful tasks (BrowserSync proxy for live reloading, Sass compilation with Autoprefixer & source maps, images optimization)
* Create the associated `package.json` (if non-existant) containing the necessary dependencies to be installed with NPM.

After the first provisioning, you should edit the `Gulpfile.js` (especially the config block at the top) to match your project structure.

## Parameters

* **gulp_gulpfile_path**: where should the gulpfile be created, defaults to <project_dir>/Gulpfile.js
* **gulp_package_json_path**: where should the package.json file be created, defaults to <project_dir>/package.json
* **gulp_package_json_author**: Author that should be put in the package.json file, defaults to "Liip AG"
* **gulp_package_json_readme**: Documentation file the should be put in the package.json file, defaults to README.md

## Default tasks
### Live reload proxy

Run BrowserSync, watch for changes in templates and Sass files, compile and reload browser with:

```
gulp watch
```

### Compile Sass once

```
gulp sass
```

You can skip the source maps with the `--production` flag.

```
gulp sass --production
```

### Optimize images

Optimizes jp(e)g, png, gif & svg files with:

```
gulp images
```
