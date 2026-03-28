Dir.glob(File.join(__dir__, "**", "*_test.rb")).sort.each do |file|
  require file
end
