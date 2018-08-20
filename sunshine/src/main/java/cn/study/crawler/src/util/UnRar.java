package cn.study.crawler.src.util;

import java.io.File;
import java.io.FileOutputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.codehaus.plexus.util.FileUtils;

import com.github.junrar.Archive;
import com.github.junrar.rarfile.FileHeader;

import cn.study.crawler.src.entity.Book;

/*

   * maven项目，添加依赖：

  *   <dependency>

           <groupId>com.github.junrar</groupId>

            <artifactId>junrar</artifactId>

            <version>0.7</version>

        </dependency>

  */
/**
 * 解压rar文件
 * @author Administrator
 *
 */
public class UnRar {

/*	public static void main(String[] args) {
		Book b=new Book("aa");
		System.out.println(b);
		System.out.println(b.getAuthor());
		String s=new String();
		System.out.println(b);
	}*/
	public static void unrar(String srcRarPath, String dstDirectoryPath) throws Exception {

		if (!srcRarPath.toLowerCase().endsWith(".rar")) {

			System.out.println("非rar文件！");

			return;

		}

		File dstDiretory = new File(dstDirectoryPath);

		if (!dstDiretory.exists()) {// 目标目录不存在时，创建该文件夹

			dstDiretory.mkdirs();

		}

		File fol = null, out = null;

		Archive a = null;
		File srcFile=null; 
		try {
			srcFile=new File(srcRarPath);
			a = new Archive(srcFile);

			if (a != null) {

//				a.getMainHeader().print(); // 打印文件信息.

				FileHeader fh = a.nextFileHeader();

				while (fh != null) {

					if (fh.isDirectory()) { // 文件夹

						// 如果是中文路径，调用getFileNameW()方法，否则调用getFileNameString()方法，还可以使用if(fh.isUnicode())

						if (existZH(fh.getFileNameW())) {

							fol = new File(dstDirectoryPath + File.separator

									+ fh.getFileNameW());

						} else {

							fol = new File(dstDirectoryPath + File.separator

									+ fh.getFileNameString());

						}

						fol.mkdirs();

					} else if(fh.getFileNameString().endsWith(".txt")) { // 文件
						if (existZH(fh.getFileNameW())) {

							out = new File(dstDirectoryPath + File.separator

									+ fh.getFileNameW().trim());

						} else {

							out = new File(dstDirectoryPath + File.separator

									+ fh.getFileNameString().trim());

						}

						// System.out.println(out.getAbsolutePath());

						try {// 之所以这么写try，是因为万一这里面有了异常，不影响继续解压.

							if (!out.exists()) {

								if (!out.getParentFile().exists()) {// 相对路径可能多级，可能需要创建父目录.

									out.getParentFile().mkdirs();

								}

								out.createNewFile();

							}

							FileOutputStream os = new FileOutputStream(out);

							a.extractFile(fh, os);

							os.close();

						} catch (Exception ex) {

							ex.printStackTrace();

						}

					}

					fh = a.nextFileHeader();

				}

				a.close();

			}

		} catch (Exception e) {

			e.printStackTrace();

		}
		srcFile.delete();
	}

	/*
	 * 
	 * 判断是否是中文
	 * 
	 */

	public static boolean existZH(String str) {

		String regEx = "[\\u4e00-\\u9fa5]";

		Pattern p = Pattern.compile(regEx);

		Matcher m = p.matcher(str);

		while (m.find()) {

			return true;

		}

		return false;

	}
	

}
