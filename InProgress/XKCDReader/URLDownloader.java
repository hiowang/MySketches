import java.util.Scanner;
import java.nio.charset.StandardCharsets;
import java.net.URL;

public class URLDownloader {

  public static String getStr(String requestURL)
  {
    try{
    try (Scanner scanner = new Scanner(new URL(requestURL).openStream(), 
      StandardCharsets.UTF_8.toString()))
    {
      scanner.useDelimiter("\\A");
      return scanner.hasNext() ? scanner.next() : "";
    }}catch(Throwable t){
      t.printStackTrace();
      return "";
    }
  }
}