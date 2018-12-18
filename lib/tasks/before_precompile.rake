task :build_frontend do
  cd './' do
    sh 'npm install'
    sh 'npm run build'
  end
end

Rake::Task['assets:precompile'].enhance(%i[build_frontend])
