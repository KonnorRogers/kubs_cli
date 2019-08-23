require 'rake'

module KubsCLI
  class FileHelper
    def copy(from:, to:)
      Rake.cp_r(from, to)
    end

    def mkdirs(*args)
      dirs.flatten.each { |dir| Rake.mkdir_p(dir) unless Dir.exist?(dir) }
    end
  end
end
