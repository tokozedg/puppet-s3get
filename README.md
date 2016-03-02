Puppet module for downloading files from S3.

Example:

```
s3get { <file name>:
	bucket   => <bucket name>,
	path     => <download path>
}
```

Optional parameters:

```
s3get { 's3 get':
  bucket       => <bucket name>,
  path         => <download path>
  src_filename => <s3 filename>,
  dst_filename => <local filename>,
  region       => <s3 region>,
  checksum     => true # Compare checksum before download
}
```
