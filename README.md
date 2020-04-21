# Git (w/ ssh) binaries for AWS Lambda

A [layer](https://aws.amazon.com/about-aws/whats-new/2018/11/aws-lambda-now-supports-custom-runtimes-and-layers/)
for AWS Lambda that allows your functions to use `git` and `ssh` binaries.

## Getting Started

You can add this layer to any Lambda function you want.
`PATH` already includes `/opt/bin` in Lambda, which is where it will be mounted.

Click on Layers and choose "Add a layer", and "Provide a layer version
ARN" and enter the following ARN (replace `us-east-1` with the region of your Lambda):

```
arn:aws:lambda:us-east-1:553035198032:layer:git-lambda2:6
```

*Note:* If you're using an older runtime, such as `python2.7`, `python3.6` ,`python3.7`, `ruby2.5`, `java8`, `go1.x`, `dotnetcore2.1`
or `provided` (custom runtime), then you'll need to use a slightly different layer:

```
arn:aws:lambda:us-east-1:553035198032:layer:git:11
```

(again, replacing `us-east-1` with the region of your Lambda)

![Provide layer ARN](https://raw.githubusercontent.com/lambci/git-lambda-layer/master/img/provide.png "Provide layer ARN screenshot")

Then click Add, save your lambda and test it out!

![Referenced layers](https://raw.githubusercontent.com/lambci/git-lambda-layer/master/img/referenced.png "Referenced layer ARN screenshot")

## Simple example on Node.js w/ https

```js
const { execSync } = require('child_process')

exports.handler = async(event) => {
  execSync('rm -rf /tmp/*', { encoding: 'utf8', stdio: 'inherit' })

  execSync('cd /tmp && git clone https://github.com/mhart/aws4', { encoding: 'utf8', stdio: 'inherit' })

  return execSync('ls /tmp/aws4', { encoding: 'utf8' }).split('\n')
}
```

## Complex example on Node.js w/ ssh

```js
const fs = require('fs')
const { execSync } = require('child_process')

exports.handler = async(event) => {
  execSync('rm -rf /tmp/*', { encoding: 'utf8', stdio: 'inherit' })

  fs.writeFileSync('/tmp/known_hosts', 'github.com,192.30.252.*,192.30.253.*,192.30.254.*,192.30.255.* ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==')

  // Get this from a safe place, say SSM
  fs.writeFileSync('/tmp/id_rsa', `-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----
`)
  execSync('chmod 400 /tmp/id_rsa', { encoding: 'utf8', stdio: 'inherit' })

  process.env.GIT_SSH_COMMAND = 'ssh -o UserKnownHostsFile=/tmp/known_hosts -i /tmp/id_rsa'

  execSync('git clone --depth 1 ssh://git@github.com/mhart/aws4.git /tmp/aws4', { encoding: 'utf8', stdio: 'inherit' })

  return execSync('ls /tmp/aws4', { encoding: 'utf8' }).split('\n')
}
```
`ssh` always tries to create a `.ssh` directory – this is something you can't avoid, nor can you specify your own destination for this – which means you'll see a warning similar to the following:
```
Could not create directory '/home/sbx_user1075/.ssh'.
```
You can ignore this warning – `ssh` should continue to execute past this point, assuming you have the `UserKnownHostsFile` option correct and it contains the signature of the host you're trying to connect to. Alternatively, you can use `-o StrictHostKeyChecking=no` if you're not concerned about MiTM attacks.

## Version ARNs for [Amazon Linux 2 runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html)

| Git version | openssh version | ARN |
| --- | --- | --- |
| 2.26.2| OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git-lambda2:6` |
| 2.26.1 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git-lambda2:5` |
| 2.25.0 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git-lambda2:4` |
| 2.24.1 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git-lambda2:3` |
| 2.24.0 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git-lambda2:2` |
| 2.23.0 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git-lambda2:1` |

## Version ARNs for all other runtimes

| Git version | openssh version | ARN |
| --- | --- | --- |
| 2.26.2 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:12` |
| 2.26.1 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:11` |
| 2.25.0 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:10` |
| 2.24.1 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:9` |
| 2.24.0 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:8` |
| 2.23.0 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:7` |
| 2.21.0 | OpenSSH_7.4p1, OpenSSL 1.0.2k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:6` |
| 2.20.0 | OpenSSH_6.6.1p1, OpenSSL 1.0.1k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:3` |
| 2.19.2 | OpenSSH_6.6.1p1, OpenSSL 1.0.1k-fips | `arn:aws:lambda:<region>:553035198032:layer:git:2` |
