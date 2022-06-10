require 'yaml'
require 'pp'

def purge_submodules
  `rm -r lib/engines/* && rm -rf .git/modules/* && touch .gitmodules && cat /dev/null > .gitmodules`
end

def add_submodule(name, repo, branch, path="lib/engines/#{name.downcase}")
  `git submodule add -b #{branch} --name #{name} --force #{repo} #{path}`
end

def add_to_gemfile
  # need to add a check for the engine inside the gemfile before adding it
  #open('Gemfile', 'a') { |f|
  #  f.puts "gem '#{name.downcase}', path: '#{path}'"
  #}
end

purge_submodules

project_config = YAML.load(File.read("blog_config.yml"))

project_config["engines"].each { |engine|
  add_submodule(engine["name"], engine["repo"], engine["branch"])
}

