task :push do
  repo = "http://bitbucket.org/akiradeveloper/gnuplotrb"
  sh "hg push #{repo}"
end

task :remove_deprecated do 
  `hg status`.split("\n").grep(/^!/).each do |x|
    sh "hg remove #{x.split.at(1)}"
  end
end
