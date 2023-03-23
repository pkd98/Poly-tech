package reference2;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Libraryview {

	private final String adminPW = "1111";
	private Scanner sc = new Scanner(System.in);
	public static List<String> rentmember;
	public static List<List<String>> rentmemberlist = new ArrayList<>();
	
	BookList booklist = new BookList();
	MemberList memberlist = new MemberList();
	
	public void playLibraryProgram() {
				
		while(true) {
			System.out.println("★★★★★★ 도서관에 오신걸 환영합니다. ★★★★★★");
			System.out.println(" 1. 도서 대여");
			System.out.println(" 2. 도서 반납");
			System.out.println(" 3. 현재 도서 대여 상황");
			System.out.println(" 4. 도서관리 프로그램 (관리자 전용)");
			System.out.println(" 5. 회원관리 프로그램 (관리자 전용)");
			System.out.println(" 6. 종료");
			System.out.println("-------------------------------");
			System.out.print("\n 무엇을 하시겠습니까? : ");
			int type = Integer.parseInt(sc.nextLine());
			
			System.out.println();
			String isreturn = null;		// 반납 할건지?? (y/n)
			String title = null;		// 책 제목
			String isadmin = null;		// 관리자인지?? (y/n)
			String id = null;			// 아이디
			String pw = null;			// 비밀번호
			
			if(type == 1) {
				// 도서 대여 (로그인 -> 대여하고 싶은 도서 선택 -> 회원 정보 / 도서 정보 수정 -> 대여 상황에 추가)
				System.out.println("--- 로그인 하세요. ---");
				System.out.print(" ○ 아이디를 입력하세요 : ");
				id = sc.nextLine();
				if(!MemberList.idpw.containsKey(id)) {				// id가 id집합에 없으면 다시 while문 다시 돌기
					System.out.println(" 아이디를 잘못 입력하셨습니다.");
					continue;
				}
				
				System.out.print(" ○ 비밀번호를 입력하세요 : ");
				pw = sc.nextLine();
				if(!MemberList.idpw.get(id).equals(pw)) {			// 해당 아이디의 비밀번호가 틀리면 while문 다시 돌기
					System.out.println(" 비밀번호를 잘못 입력하셨습니다.");
					continue;
				}
				
				System.out.println("\n 로그인에 성공하였습니다! \n");
				
				rentmember = new ArrayList<>();
				rentmember.add(id);			// 도서 대여자 id추가
				
				// 도서 정보 수정 (동인한 id의 회원 정보를 도서 대여중으로 수정)
				for(int i = 0; i < MemberList.memberlist.size(); i++) {
					if(MemberList.memberlist.get(i).get(2).equals(id)) {
						MemberList.memberlist.get(i).remove(4);
						MemberList.memberlist.get(i).add("현재 도서 대여 중");
					}
				}
				
				booklist.rent();			// 도서 빌리기 (도서 대여자에 빌린 책 제목, 책 번호 추가 및 도서 정보 수정 포함)
				
				rentmemberlist.add(rentmember);			// 도서 대여자 명단에 도서 대여자 추가
				
				
			}else if(type == 2) {
				// 도서 반납 (로그인 -> 반납할건지 확인 -> 대여 상황 수정 -> 회원 정보 / 도서 정보 수정)
				// 돌이키기에 너무 많이 진행되어 메서드를 사용하지 않고 진행,,,
				System.out.println("--- 로그인 하세요. ---");
				System.out.print(" ○ 아이디를 입력하세요 : ");
				id = sc.nextLine();
				
				if(!MemberList.idpw.containsKey(id)) {				// id가 id집합에 없으면 다시 while문 다시 돌기
					System.out.println(" 아이디를 잘못 입력하셨습니다.");
					continue;
				}
				System.out.print(" ○ 비밀번호를 입력하세요 : ");
				pw = sc.nextLine();
				if(!MemberList.idpw.get(id).equals(pw)) {			// 해당 아이디의 비밀번호가 틀리면 while문 다시 돌기
					System.out.println(" 비밀번호를 잘못 입력하셨습니다.");
					continue;
				}
				
				System.out.println(" 로그인에 성공하였습니다!");
				
				// 도서관내 도서 대여 상황 수정
				for(int i = 0; i < rentmemberlist.size(); i++) {
					if(rentmemberlist.get(i).get(0).equals(id)) {
						System.out.printf(" %s님이 대여 중인 도서는 %s입니다. \n", id, rentmemberlist.get(i).get(1));		
						title = rentmemberlist.get(i).get(1);
						System.out.print(" 도서 반납을 하시겠습니까? (y / n) : ");
						isreturn = sc.nextLine();
						// 반납할건지 다시 확인
						if(isreturn.equalsIgnoreCase("y")) {
							rentmemberlist.remove(i);
						}
					}
				}
				// 회원 정보 수정 (회원 아이디를 통해 정보 수정)
				for(int i = 0; i < MemberList.memberlist.size(); i++) {
					if(MemberList.memberlist.get(i).get(2).equals(id)) {
						MemberList.memberlist.get(i).remove(4);
						MemberList.memberlist.get(i).add("현재 대여 중인 도서 없음");
					}
				}
				// 도서 정보 수정 (도서 제목을 통해 정보 수정)
				for(int i = 0; i < BookList.booklist.size(); i++) {
					if(BookList.booklist.get(i).get(0).equals(title)) {
						BookList.booklist.get(i).remove(4);
						BookList.booklist.get(i).add("대여 가능");						
					}
				}
				
				System.out.println(" 도서 반납이 완료되었습니다.");
				
			} else if(type == 3) {
				// 대여 상황 확인
				showrentstate();				
			} else if(type == 4) {
				// 도서관리 프로그램으로 넘어가기 (관리자인지 확인 -> 도서관리 프로그램 진행)
				System.out.print(" ○ 관리자 입니까? (y / n) : ");
				isadmin = sc.nextLine();
				// 관리자인지 확인
				if(isadmin.equalsIgnoreCase("y")) {
					// 틀리면 다시 비밀번호 입력하도록 반복문 실행
					while(true) {						
						System.out.print(" ○ 비밀번호를 입력하세요 : ");
						pw = sc.nextLine();
						
						// 비밀번호 확인
						if(pw.equals(adminPW)) {
							System.out.println("\n--- 도서관리 프로그램을 시작합니다. ---");
							booklist.bookshow();	// 비밀번호가 맞다면 도서관리 프로그램 실행
							break;
						} else {
							System.out.println(" 틀렸습니다.");	
						}
					}
				} else if(isadmin.equalsIgnoreCase("n")) {
					System.out.println(" 접근 할 수 없습니다.");
				} else {
					System.out.println(" 잘못된 입력입니다.");
				}
				
			}else if(type == 5) {
				// 회원 관리 프로그램으로 넘어가기 (관리자인지 확인 -> 회원관리 프로그램 진행)
				System.out.print(" ○ 관리자 입니까? (y / n) : ");
				isadmin = sc.nextLine();
				// 관리자인지 확인
				if(isadmin.equalsIgnoreCase("y")) {
					// 틀리면 다시 비밀번호 입력하도록 반복문 실행
					while(true) {						
						System.out.print(" ○ 비밀번호를 입력하세요 : ");
						pw = sc.nextLine();
						
						// 비밀번호 확인
						if(pw.equals(adminPW)) {	
							System.out.println("\n--- 회원관리 프로그램을 시작합니다. ---");
							memberlist.membershow();	// 비밀번호가 맞다면 회원관리 프로그램 실행
							break;
						} else {
							System.out.println(" 틀렸습니다.");
						}
					}
				} else if(isadmin.equalsIgnoreCase("n")) {
					System.out.println(" 접근 할 수 없습니다.");
				} else {
					System.out.println(" 잘못된 입력입니다.");
				}
				
			}else if(type == 6) {
				System.out.println(" 도서관을 나갑니다.");
				System.out.println(" 저희 도서관을 방문해 주셔서 감사합니다!!");
				System.out.println(" 다음에 또 오세요~");
				break;
			}else {
				System.out.println(" 잘못된 입력입니다 다시 입력하세요.");
			}
			System.out.println();	// 보기 편하게 한칸 띄어쓰기
		}
	}
	
	public void showrentstate() {
		System.out.println(" ● 현재 도서관 내 도서 대여 상황입니다.");
		if(rentmemberlist.size() == 0) {
			System.out.println(" 현재 대여 현황은 없습니다.");
		}
		for(int i = 0; i < rentmemberlist.size(); i++) {
			System.out.printf(" ID : %s, 빌린 도서 : %s, 책 번호 : %s \n", rentmemberlist.get(i).get(0), rentmemberlist.get(i).get(1), rentmemberlist.get(i).get(2));
		}
	}
	
}
