#!/usr/bin/env ruby

require 'fileutils'

def get_input()
    puts %x( clear )
    puts "Select task:\n\n"
    puts "1. Extract language files\n"
    puts "2. Insert language files\n"
    puts "0. Quit\n\n"

    input = gets.to_i

    unless input < 3
        puts 'Not a valid task!'
        return 0
    else
        return input
    end
end

def clean()
    lang_files = Dir['Language/*']

    lang_files.each do |filename|
        FileUtils.rm(filename)
    end

    FileUtils.rm('en-GB.zip') if File.exist?('en-GB.zip')

    FileUtils.rm_rf('web') if File.exist?('web')
end

def clone()
    puts 'Cloning repository from github..'
    puts %x( git clone https://github.com/monsenso/web )
end

def push()
    puts 'Creating language-files branch and push for github...'

    Dir.chdir('web/')

    puts %x( git checkout -b language-files develop)
    puts %x( git add . )
    puts %x( git commit -m "Update language files" )
    puts %x( git push -u origin language-files )
end

def compress()
    puts 'Creating compressed file...'
    puts %x( zip en-GB.zip -r Language )
end

def pullFiles()
    puts 'Extracting language files from directories...'

    FileUtils.rm_f Dir.glob('Language/*')

    lang_files = Dir['**/i18n-en-GB.json']

    lang_files.each do |file_path|
        filename = file_path

        if filename.include? '_'
            filename = filename.gsub('_', '(')
            filename = filename.gsub('.', ').')
        end

        filename = filename.gsub('/', '_')

        FileUtils.cp(file_path, "Language/#{filename}")
    end
end

def renameFiles(language)
    puts 'Rename language ' + language + ' files...'

    lang_files = Dir[language + '/*']

    lang_files.each do |filename|
        dest_file = filename.gsub(language, 'Language')
        dest_file = dest_file.gsub('en-GB', language)

        FileUtils.mv(filename, dest_file)
    end
end

def pushFiles()
    puts 'Fetching language files to directories...'

    lang_files = Dir['Language/*']

    lang_files.each do |filename|
        dest_file = filename.gsub('Language/', '')
        dest_file = dest_file.gsub('_', '/')

        if dest_file.include? '('
            dest_file = dest_file.gsub('(', '_')
            dest_file = dest_file.gsub(').', '.')
        end

        FileUtils.cp(filename, dest_file)
    end
end

case get_input
when 1
    clean()
    clone()
    pullFiles()
    compress()
    puts 'Done.'
when 2
    clean()
    clone()

    languages = ['da-DK', 'de-DE', 'es-ES', 'it-IT', 'nb-NO', 'sv-SE', 'fr-FR', 'all-languages']

    languages.each do |language|
        renameFiles(language)
    end

    pushFiles()
    push()

    puts 'Done.'
else
    puts 'Goodbye...'
end
