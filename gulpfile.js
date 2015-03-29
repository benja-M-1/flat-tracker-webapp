var gulp = require('gulp')
    , path  = require('path')
    , concat = require('gulp-concat')
    , changed = require('gulp-changed')
    , gutil = require('gulp-util')
    , gif = require('gulp-if')
    , jade = require('gulp-jade')
    , templateCache = require('gulp-angular-templatecache')
    , webserver = require('gulp-webserver')
    , less = require('gulp-less')
    , ngConfig = require('gulp-ng-config')
    , env = process.env.NODE_ENV || 'dev';
;

gulp.task('default', ['build']);

gulp.task('webserver', ['build'], function () {
    gulp.src('www')
        .pipe(webserver({
            host: '127.0.0.1',
            port: 5011,
            livereload: true
        })
    );
});

gulp.task('watch', ['webserver'], function () {
    gulp.watch('src/**', ['build']);
});

gulp.task('build', ['config', 'javascripts', 'templates', 'stylesheets', 'copyfonts', 'copyimages', 'views']);

gulp.task('views', function (done) {
    gulp.src([
        'src/*.jade'
    ])
        .pipe(jade({pretty: true}))
        .pipe(gulp.dest('./www'))
        .on('error', gutil.log)
        .on('end', done)
    ;
});

gulp.task('templates', function (done) {
    gulp.src([
        'src/templates/*.jade'
    ])
        .pipe(jade({pretty: true}))
        .pipe(templateCache({
            filename: 'templates.js',
            module: 'flatTracker.templates',
            standalone: true
        }))
        .pipe(gulp.dest('./www/js'))
        .on('error', gutil.log)
        .on('end', done)
    ;
});

gulp.task('stylesheets', function (done) {
    gulp.src(['src/styles/flat-tracker.less'])
        .pipe(less())
        .pipe(changed('css'))
        .pipe(concat('flat-tracker.css'))
        .pipe(gulp.dest('./www/css'))
        .on('error', gutil.log)
        .on('end', done)
    ;
});

gulp.task('copyfonts', function (done) {
    gulp.src([
        'bower_components/bootstrap/fonts/*.{ttf,woff,woff2,eot,svg}',
        'src/fonts/*.{ttf,woff,woff2,eot,svg}'
    ])
        .pipe(gulp.dest('./www/fonts'))
        .on('error', gutil.log)
        .on('end', done)
    ;
});

gulp.task('copyimages', function (done) {
    gulp.src([
        'src/images/*'
    ])
        .pipe(gulp.dest('./www/images'))
        .on('error', gutil.log)
        .on('end', done)
    ;
});

gulp.task('javascripts', function (done) {
    gulp.src([
        'bower_components/jquery/dist/jquery.min.js',
        'bower_components/bootstrap/dist/js/bootstrap.min.js',
        'bower_components/uri.js/src/URI.min.js',
        'bower_components/moment/min/moment-with-locales.min.js',
        'bower_components/parse-angular-patch/dist/parse-angular.js',
        'bower_components/angular/angular.min.js',
        'bower_components/angular-momentjs/angular-momentjs.min.js',
        'bower_components/angular-ui-router/release/angular-ui-router.min.js',
        'bower_components/angular-intercom/angular-intercom.min.js',
        'libs/*.js',
        'src/*.js'
    ])
        .pipe(gif(env == "production" || env == "prod", concat('flat-tracker.js')))
        .pipe(gulp.dest('./www/js'))
        .on('error', gutil.log)
        .on('end', done)
    ;
});

gulp.task('config', function () {
    gulp.src('./config.json')
        .pipe(ngConfig('flatTracker.config', {
            environment: env
        }))
        .pipe(gulp.dest('./www/js'))
    ;
});