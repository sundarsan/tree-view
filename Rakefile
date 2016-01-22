def run(command)
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

namespace "run" do
  desc "Run unit tests for all iOS targets"
  task :ios do |t|
  	run "xcodebuild -project RXTreeControl.xcodeproj  -scheme RXTreeControl"
    
  end

end

task default: ["run:ios"]