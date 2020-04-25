require 'webrick'
require 'json'
srv = WEBrick::HTTPServer.new({ :DocumentRoot => './',
                                :BindAddress => '0.0.0.0',
                                :Port => ENV['PORT'].to_i})
srv.mount_proc '/' do |req, res|
  res.body = `sh -e ./main.sh 2>&1`
  STDOUT.puts res.body
  STDOUT.flush
  if $? != 0
    res.status = 500
    STDERR.puts JSON.generate(
      "@type": 'type.googleapis.com/google.devtools.clouderrorreporting.v1beta1.ReportedErrorEvent',
      message: 'ジョブの実行に失敗しました'
    )
    STDERR.flush
  end
end
trap("INT"){ srv.shutdown }
srv.start
