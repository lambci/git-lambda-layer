const { execSync } = require('child_process')

exports.handler = async(event) => {
  execSync('rm -rf /tmp/*', { encoding: 'utf8', stdio: 'inherit' })

  execSync('cd /tmp && git clone https://github.com/mhart/aws4', { encoding: 'utf8', stdio: 'inherit' })

  return execSync('ls /tmp/aws4', { encoding: 'utf8' }).split('\n')
}
