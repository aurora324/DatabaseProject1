import java.io.*;

public class Generation {
    public static void main(String[] args) throws IOException {
        danmu();
        users();
        videos();
    }
    public static void danmu() throws IOException {
        File inputFile = new File("src/danmu.csv");
        File outputFile = new File("src/danmu.sql");
        if(outputFile.exists()){
            if(outputFile.delete()){
                System.out.println("delete");
            }
            if(outputFile.createNewFile()){
                System.out.println("new file");
            }
        }
        FileWriter fileWriter = new FileWriter(outputFile);
        try (FileReader fileReader = new FileReader(inputFile);
             BufferedReader bufferedReader = new BufferedReader(fileReader)) {
            bufferedReader.readLine();
            System.out.println("write");
            String line = null;
            while ((line = bufferedReader.readLine()) != null) {
                fileWriter.write("INSERT INTO danmu (BV, mid, time,content) values ("+line+");\n");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            fileWriter.flush();
            fileWriter.close();
        }
    }

    public static void users() throws IOException {
        File inputFile = new File("src/users.csv");
        File outputFile = new File("src/users.sql");
        if(outputFile.exists()){
            if(outputFile.delete()){
                System.out.println("delete");
            }
            if(outputFile.createNewFile()){
                System.out.println("new file");
            }
        }
        FileWriter fileWriter = new FileWriter(outputFile);
        try (FileReader fileReader = new FileReader(inputFile);
             BufferedReader bufferedReader = new BufferedReader(fileReader)) {
            bufferedReader.readLine();
            System.out.println("write");
            String line = null;
            while ((line = bufferedReader.readLine()) != null) {
                fileWriter.write("INSERT INTO users (Mid,Name,Sex,Birthday,Level,Sign,following,identity) values ("+line+");\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            fileWriter.flush();
            fileWriter.close();
        }
    }

    public static void videos() throws IOException {
        File inputFile = new File("src/videos.csv");
        File outputFile = new File("src/videos.sql");
        if(outputFile.exists()){
            if(outputFile.delete()){
                System.out.println("delete");
            }
            if(outputFile.createNewFile()){
                System.out.println("new file");
            }
        }
        FileWriter fileWriter = new FileWriter(outputFile);
        try (FileReader fileReader = new FileReader(inputFile);
             BufferedReader bufferedReader = new BufferedReader(fileReader)) {
            bufferedReader.readLine();
            System.out.println("write");
            String line = null;
            while ((line = bufferedReader.readLine()) != null) {
                fileWriter.write("INSERT INTO videos (BV,Title,Owner Mid,Owner Name,Commit Time,Review Time,Public Time,Duration,Description,Reviewer,Like,Coin,Favorite,View) values ("+line+");\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            fileWriter.flush();
            fileWriter.close();
        }
    }
}
