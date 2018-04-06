import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
//PImage[] memes = new PImage[13];
int index = 0;

Twitter twitter;
java.util.List<Status> tweets;
int saveTime;
int durTime= 240000;
void setup() {
  //for (int i = 0; i < memes.length; i++){
  //  memes[i] = loadImage("IMG_"+i+".JPG");
  
 // }
  saveTime = millis();
  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("BqxzmjiFtGstZlhsPQSRW2GmK");
  cb.setOAuthConsumerSecret("gCEntM1v8hu1qjPmI0qUOUgjbAWnTlg9HEP9IA4nhzpgaK4fk1");
  cb.setOAuthAccessToken("967146964407037952-342tdYizUapOfadfWew09t3W0EYgp4S");
  cb.setOAuthAccessTokenSecret("gob6jHjeZj0pw5hZcy7ozxQMuASJqHLbjKCF6t5RPrY0h");

  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();
  println(twitter);
}

void draw() {
  
  int passTime = millis()- saveTime;
  if(passTime > durTime){
  
    String searchString = "contemporary art";

  try {
    Query query = new Query(searchString);

    QueryResult result = twitter.search(query);

    tweets = result.getTweets();

    int i = 1;
    for (Status tweet : tweets) {
      println("----------- tweet #"+i+" ---------------");
      String newTweetText ="RT "+"https://twitter.com/"+tweet.getUser().getScreenName()+"/status/"+tweet.getId();
      StatusUpdate newTweet = new StatusUpdate(newTweetText);
      index = int(random(13));
      File f = new File(dataPath("IMG_"+index+".JPG"));
      println(f);
      newTweet.setMedia(f);
      twitter.updateStatus(newTweet);
      i++;
      break;
    }
  }
  catch (TwitterException te) {
    System.out.println("Twitter error: " + te.getMessage());
    System.exit(-1);
  }
  durTime = 239950;
    saveTime = millis();
  }
  
}