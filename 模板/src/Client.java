
public class Client {
    public static void main(String[] args) {
        DataManipulation dm = null;
        try {
            dm = new DataFactory().createDataManipulation("database");
            //dm.addOneMovie("流浪地球;cn;2019;127");
           // System.out.println(dm.allContinentNames());
            //System.out.println(dm.continentsWithCountryCount());
            //System.out.println(dm.findMovieById(10));
        } catch (IllegalArgumentException e) {
            System.err.println(e.getMessage());
        }
    }
}

