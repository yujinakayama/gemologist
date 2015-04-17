module FileHelper
  module_function

  def create_file(file_path, content)
    require 'fileutils'

    dir_path = File.dirname(file_path)
    FileUtils.makedirs(dir_path) unless File.exist?(dir_path)

    File.open(file_path, 'w') do |file|
      case content
      when String then file.puts content
      when Array  then file.puts content.join("\n")
      else fail 'Unsupported type!'
      end
    end
  end
end
