# 0.8.6
- Issue #7 *Provide url for key-only enumeration*
    top-level configurations url now accepts `?short=true` to return shortened display of entries
- Issue #10 *noah-watcher daemon doesn't support REDIS_URL env*
    **BREAKING CHANGE** noah-watcher.rb renamed to noah-watcher
    noah-watcher now supports `-r redis://host:port/dbnum` to use alternate redis server
    noah-watcher now supports `-l logfile` for logging to file
# 0.8.5
- Issue #9 *Ephemeral Tagging is broken*
    All tagging now moved from route files to Sinatra helper
# Historical
This changelog started being maintained at 0.8.5. Previous changes can be viewed in the commit history.
