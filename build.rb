require 'yaml'
require 'pp'

def purge_submodules
  #submodules = `git config --file .gitmodules --get-regexp path`.split(' ')
  #              .select do |val|
  #                val.include?("/")
  #              end

  #pp submodules

  #submodules.each { |path|
    #`git rm --cached #{path}`
    `rm -r lib/engines/*`
  #}
   
  `rm -rf .git/modules/*`
  `touch .gitmodules && cat /dev/null > .gitmodules`

end

#purge_submodules

def add_submodule(name, repo, branch, path="lib/engines/#{name.downcase}")
  #add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
  #p "git submodule add -b #{branch} --name #{name} #{repo} #{path}"
  `git submodule add -b #{branch} --name #{name} --force #{repo} #{path}`

  open('Gemfile', 'a') { |f|
    f.puts "gem '#{name.downcase}', path: '#{path}'"
  }
end

project_config = YAML.load(File.read("blog_config.yml"))

project_config["engines"].each { |engine|
  add_submodule(engine["name"], engine["repo"], engine["branch"])
}

