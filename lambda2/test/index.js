const { execSync } = require('child_process')

exports.handler = async(event) => {
  execSync('rm -rf /tmp/*', { encoding: 'utf8', stdio: 'inherit' })

  execSync('cd /tmp && git clone https://github.com/mhart/aws4', { encoding: 'utf8', stdio: 'inherit' })

  execSync('ls -l /tmp/aws4', { encoding: 'utf8', stdio: 'inherit' })

  execSync('ldd /opt/bin/git', { encoding: 'utf8', stdio: 'inherit' })

  execSync('ldd /opt/bin/ssh', { encoding: 'utf8', stdio: 'inherit' })

  execSync('ssh -V', { encoding: 'utf8', stdio: 'inherit' })
}
