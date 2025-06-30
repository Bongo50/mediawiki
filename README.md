# Bongo50's Docker MediaWiki configuration.

Forked from [the Team Fortress Wiki](https://github.com/tfwiki/mediawiki).

## Configuration
*Not all up to date!*

| Variable                  | Default                               | Associated MediaWiki variable | Notes                                                                                                  |
| ------------------------- | ------------------------------------- | ----------------------------- | ------------------------------------------------------------------------------------------------------ |
| `DB_DB`                   | `wiki`                                | `$wgDBname`                   |
| `DB_HOST`                 | `db`                                  | `$wgDBserver`                 |
| `DB_PASSWORD`             | –                                     | `$wgDBpassword`               |
| `DB_TYPE`                 | `mysql`                               | `$wgDBtype`                   |
| `DB_USER`                 | `wiki`                                | `$wgDBuser`                   |
| `EMAIL_EMERGENCY_CONTACT` | \*Required with SMTP\_\*\*            | `$wgEmergencyContact`         |
| `EMAIL_PASSWORD_SENDER`   | \*Required with SMTP\_\*\*            | `$wgPasswordSender`           |
| `MEMCACHED_HOST`          |                                       | `$wgMemCachedServers`         |                                                                                                        |
| `READ_ONLY_MESSAGE`       | -                                     | `$wgReadOnly`                 | If set, puts the Wiki into read-only mode with the given message.                                      |
| `RECAPTCHA_KEY`           | _Required_                            | `$wgReCaptchaSiteKey`         | Credentials for a ReCaptcha v2 Tickbox                                                                 |
| `RECAPTCHA_SECRET`        | _Required_                            | `$wgReCaptchaSecretKey`       | Credentials for a ReCaptcha v2 Tickbox                                                                 |
| `SECRET_KEY`              | _Required_                            | `$wgSecretKey`                |                                                |
| `SERVER_URL`              | _Required_                            | `$wgServer`                   |
| `SITENAME`                | `Bongo50 Testing Wiki`                | `$wgSitename`                 |
| `SMTP_AUTH`               | -                                     | `$wgSMTP['auth']`             |
| `SMTP_HOST`               | -                                     | `$wgSMTP['Host']`             |
| `SMTP_IDHOST`             | -                                     | `$wgSMTP['IDHost']`           |
| `SMTP_PASSWORD`           | -                                     | `$wgSMTP['password']`         |
| `SMTP_PORT`               | -                                     | `$wgSMTP['port']`             |
| `SMTP_USERNAME`           | -                                     | `$wgSMTP['username']`         |
