if Rails.env == "production"
  # set credentials from ENV hash
  S3_CREDENTIAL = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "schedquarters"}
else
  # get credentials from YML file
  S3_CREDENTIAL = YAML.load_file("#{Rails.root}/config/s3.yml")
end