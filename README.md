# Bongo50's Docker MediaWiki configuration.

Forked from [the Team Fortress Wiki](https://github.com/tfwiki/mediawiki).

## Running locally

The wiki can be ran locally via `docker-compose`:

- Build a `bongo50/mediawiki:local` image from source: `make`
- Update your hosts file to map `mediawiki.localhost` to the host IP (presumably `127.0.0.1`)
- Create `.env` file with the variables to configure your stack (`cp .env.example .env`; `.env.example` is pre-configured for running locally)
- Generate some self-signed SSL certs: `make certs`
- Bring up the stack! `docker-compose up -d`

## Configuration

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
