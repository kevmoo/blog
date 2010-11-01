module Scratch
  def self.text_mate_url(path)
    puts path
    "txmt://open/?url=file://#{path}"
  end

  def self.haml_path
    File.join(Rails.root, 'tmp', 'scratch', 'scratch.haml')
  end

end
