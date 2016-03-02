# bucket and path parameters are mandatory

define s3get(
  $bucket,
  $path,
  $src_filename = $name,
  $dst_filename = $name,
  $checksum = true,
  $region = 'us-east-1'
){

  $src_url = "s3://${bucket}/${src_filename}"
  $dst_path = "${path}/${dst_filename}"

  Exec {
    path => '/bin:/usr/bin:/usr/sbin'
  }

  case $::operatingsystem {
    'Ubuntu': {
      $awsCli = 'awscli'

      package { $awsCli:
        ensure => present,
      }
    }
    default: {

    }
  }

  if $checksum {

    exec { "s3get_${src_url}":
      command => "aws s3 --region ${region} cp ${src_url} ${dst_path}",
      unless  => epp('s3get/checksum.sh.epp', {
        'bucket' => $bucket,
        'file'   => $src_filename,
        'path'   => $dst_path,
        })
    }

  } else {

    exec { "s3get_${src_url}":
      command => "aws s3 cp ${src_url} ${dst_path}",
    }
  }
}
