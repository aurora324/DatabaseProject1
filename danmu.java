import java.io.*;

public class danmu {
    public static void main(String[] args) throws FileNotFoundException {
        File inputFile = new File("src\\danmu.csv");
        try {
            FileInputStream fileInputStream=new FileInputStream(inputFile);//这里需要进行抛出异常处理
            for (int i = 0; i < inputFile.length(); i++) {
                char ch=(char)(fileInputStream.read());//循环读取字符
                System.out.print(ch+" ");
            }
            System.out.println();//换行操作
            fileInputStream.close();//关闭文件
        } catch (Exception e) {
            System.out.println("文件打开失败");
        }

        File outputFile=new File("src\\danmu.sql");
        FileOutputStream fileOutputStream=new FileOutputStream(outputFile);//(file,true)，这里有true的话，代表可以在文件后面追加内容
        String str="I love coding";
        byte[] buff=str.getBytes();//将字符串转换为字节数组
        try {
            fileOutputStream.write(buff);//把字节数组的内容写进去文件
        } catch (Exception e) {
            // TODO: handle exception
        }finally {
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }


        File file=new File("src\\cc.txt");
        //文件读取对象
        //字符流对象
        try (FileReader fileReader = new FileReader(file);
             BufferedReader bufferedReader = new BufferedReader(fileReader)) {
            //循环打印cc文件中的每行数据
            String line = null;
            while ((line = bufferedReader.readLine()) != null) {
                System.out.println(line);
            }

        } catch (Exception e) {
            // TODO: handle exception
        }
        // TODO: handle exception


    }
}
