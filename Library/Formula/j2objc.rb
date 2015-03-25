class J2objc < Formula
  homepage "http://j2objc.org"
  url "https://github.com/google/j2objc/archive/0.9.6.1.tar.gz"
  sha256 "ff3e1da035dbaa4fc19e59cb74e3420b252bc328abb3b0e46acfce95416fdb3a"
  head "https://github.com/google/j2objc.git"

  depends_on "maven" => :build
  depends_on :java => "1.7+"

  def install

    # Call make dist to build the full distribution
    system "make", "dist", ENV["MAKEFLAGS"]

    # Run all unit tests
    system "make", "test", ENV["MAKEFLAGS"]

    # Remove all files generated by the build.
    system "make" "clean"


    # Install to binary
    bin.install "dist/j2objc"
    bin.install "dist/j2objcc"
  end

  test do
    File.open("Hello.java", 'w') {|f| f.write("public class Hello {
  public static void main(String[] args) {
    System.out.println(\"hello, world\");
  }
}") }

    system "j2objc" "Hello.java"
    system "j2objcc" "-c" "Hello.m"
    system "j2objcc" "-o" "hello" "Hello.o"
    system "./hello" "Hello"
    system "false"
  end
end