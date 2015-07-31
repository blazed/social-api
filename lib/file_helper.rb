require 'open-uri'

class FileHelper

  def self.download(url, tmp_file, redirect=false)

    uri = URI.parse(url)
    extension = File.basename(uri.path)
    tmp = Tempfile.new([tmp_file, extension])

    File.open(tmp.path, 'wb') do |f|
      downloaded = uri.open('rb', read_timeout: 5, redirect: redirect)
      while data = downloaded.read(512.kilobytes)
        f.write(data)
      end

      downloaded.try(:close!) rescue nil
    end

    tmp
  end
end