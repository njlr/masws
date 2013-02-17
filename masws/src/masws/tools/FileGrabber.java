package masws.tools;

import java.io.File;
import java.io.IOException;
import java.net.URL;

public strictfp final class FileGrabber {
	
	private FileGrabber() {
		
		super();
	}
	
	public static void main(final String[] args) throws IOException {
		
		if (args.length != 2) {
			
			System.out.println("File Grabber");
			System.out.println("A tool for downloading and saving a file. ");
			System.out.println("If the destination file already exists it will be overwritten. ");
			System.out.println();
			
			System.out.println("Usage: ");
			System.out.println("\t0 - Source file URL");
			System.out.println("\t1 - Destination file");
			System.out.println();
			
			return;
		}
		
		final URL url = new URL(args[0]);
		final File file = new File(args[1]);
		
		System.out.println("Downloading " + url.toString() + " to " + file.toString() + "... ");
		
		org.apache.commons.io.FileUtils.copyURLToFile(url, file);
		
		System.out.println("Done");
	}
}
