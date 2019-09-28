class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def public_id
    cloudinary_folder + model.class.name
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

private

  def cloudinary_folder
    MariageParticipatif::CloudinaryStoreDir
  end
end
