package reference3;

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import kr.ac.kopo.util.FileClose;

public class MemberList extends Members implements Member {

	Scanner sc = new Scanner(System.in);
	
	private int num = 1;
	static List<List<String>> memberlist = new ArrayList<>();
	static Map<String, String> idpw = new HashMap<>();	// 회원 아이디 비밀번호 저장
	
	BookList booklist = new BookList();
	
	
	public void membershow() {
		System.out.println("------ 회원관리 프로그램입니다. ------");
		System.out.println(" 1. 회원 등록");
		System.out.println(" 2. 총 회원 리스트 보기");
		System.out.println(" 3. 현재 대여 중인 회원 리스트 보기");
		System.out.println(" 4. 종료");
		System.out.println("-------------------------------");
		
		
		
		while(true) {
			System.out.print("\n 무엇을 하시겠습니까? : ");
			int type = Integer.parseInt(sc.nextLine());
			if(type == 1) {
				register();
			}else if(type == 2) {
				mlist();
			}else if(type == 3) {
				rentingMember();
			}else if(type == 4) {
				System.out.println(" 프로그램을 종료합니다.");
				break;
			}else {
				System.out.println(" 잘못된 입력입니다 다시 입력하세요.");
			}
		}		
	}
	
	
	@Override
	public void register() {
		Members member = new Members("최덕재" + num, "010-1234-"+(int) (Math.random()*9999), "cdj"+num, "111" + num++);
		List<String> newMember = new ArrayList<>();
		newMember.addAll(member.memberinfo());
		idpw.put(newMember.get(2), newMember.get(3));
		newMember.add("현재 대여 중인 도서 없음");
		memberlist.add(newMember);
		System.out.printf(" 회원 등록이 완료되었습니다. (이름 : %s, 아이디 : %s)\n", newMember.get(0), newMember.get(2));
	}

	// 회원정보를 txt파일로 저장
	@Override
	public void mlist() {
		System.out.println("------ 2. 도서관 내 총 회원 리스트 ------");
		
		FileOutputStream fos = null;
		DataOutputStream dos = null;
		
		try {
			fos = new FileOutputStream("project01/memberlist.txt");
			dos = new DataOutputStream(fos);
			
			for(int i = 0; i < memberlist.size(); i++) {
				System.out.printf("회원 이름 : %s, 전화번호 : %s, 회원 ID : %s, 회원 비밀번호 : %s, %s \n",
						memberlist.get(i).get(0),memberlist.get(i).get(1),memberlist.get(i).get(2),memberlist.get(i).get(3),memberlist.get(i).get(4));
				
				dos.writeUTF(memberlist.get(i).get(0) + " / " + memberlist.get(i).get(1) + " / " + memberlist.get(i).get(2) + " / " + memberlist.get(i).get(4) + "\n");
			}
			
			dos.flush();
			System.out.println(" * memberlist에 저장 완료....");
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			FileClose.close(dos, fos);
		}
		
		System.out.printf(" * 총 회원은 %d명 입니다.\n", memberlist.size());
	
	}

	@Override
	public void rentingMember() {
		int rcnt = 0;
		System.out.println("------ 3. 현재 대여 중인 회원 리스트 ------");
		for(int i= 0; i < memberlist.size(); i++) {
			if(memberlist.get(i).get(4).equals("현재 도서 대여 중")) {
				System.out.printf(" 회원 이름 : %s, 회원 ID : %s \n", memberlist.get(i).get(0), memberlist.get(i).get(2));
				rcnt++;
			}
		}
		System.out.printf(" * 현재 도서 대여 중인 회원은 %d명 입니다.\n", rcnt);
	}

	
}
