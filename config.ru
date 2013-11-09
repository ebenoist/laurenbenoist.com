require "json"

use Rack::Static,
  :urls => ["/images", "/js", "/css", "/fonts" ],
  :root => "public"

run lambda { |env|
  request_path = env["REQUEST_PATH"]
  file = request_path == "/" ? "public/index.html" : "public#{request_path}"

  if File.exists?(file)
    build_response(200, File.open(file, File::RDONLY))
  else
    build_response(200, File.open("public/index.html", File::RDONLY))
  end
}

def build_response(code, file)
  [ code, { 'Content-Type'  => 'text/html', 'Cache-Control' => 'public, max-age=86400'}, file ]
end

