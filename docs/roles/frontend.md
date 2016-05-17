# Compass

Install Compass and incidentally Sass. Also install the Ruby role as a dependency.

# Gulp

* Install `gulp` globally in the Vagrant box
* Create a prefilled `Gulpfile.js` (if nonexistant) with useful tasks (BrowserSync proxy for live reloading, Sass compilation with Autoprefixer & source maps, images optimization)
* Create the associated `package.json` (if nonexistant) mentionning the necessary dependencies to be installed with NPM.

After the first provisionning, you should edit the `Gulpfile.js` (especially the config block at the top) to match your project structure.

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
