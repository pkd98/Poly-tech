package reference2;

public interface Book {

	public void rent();				// 도서 대여
	public void reTurn();			// 도서 반납
	public void register();			// 도서 등록
	public void blist();			// 도서 총 목록
	public void rentPossible();		// 대여 가능한 도서 목록
	public void rentImpossible();	// 현재 대여중인 도서 목록
}
