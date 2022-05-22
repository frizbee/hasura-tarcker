#!/usr/bin/env ruby

require 'json'
require 'open3'
require 'yaml'

file = "/home/deployer/apps/hasura-tracker/hasura_changes.txt"
hasura_dir = "/home/deployer/apps/hasura"

Open3.popen3("hasura metadata diff", chdir: hasura_dir) do |i,o,e,t|
  json = YAML.load(e.read.chomp)
  output = o.read.chomp
  changes = output.split("\n\n")

  if output.count('a-zA-Z') > 0
    File.open(file, 'a+') do |f|
      changes.each_slice(2) do |table, str|
        f.write("------------------------------------------\n\n")
        f.write("Time changed: " + json['time'] + "\n")
        clear_table = table.match(/(?<=public\_).*(?=\.)/)
        f.write("Table: " + clear_table.to_s + "\n\n")
        f.write(str + "\n")
      end
    end
    Open3.capture3("hasura metadata export", chdir: hasura_dir)
  end
end
