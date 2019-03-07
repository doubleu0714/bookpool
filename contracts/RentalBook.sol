pragma solidity 0.5.0;

contract RentalBook {
	// 책 등록 기본 수수료
	uint SYSTEM_FEE = 1 ether;
	uint CANCEL_FEE = 1 ether;
	address payable owner = msg.sender;

	// 대여 한건에 대한 구조체
	struct RentalInfo {
		uint id; // 클라이언트 앱에서 생성한 고유 ID
		address payable lender; // 책 대여자 계정
		address payable borrower; // 책 대출자 계정
		uint deposit; // 보증금
		uint rentalFee; // 대여 수수료
		uint systemFee; // 책 등록시 수수료
		bool isRented; // 대여 여부
	}

	// id 생성변수
	uint idGenerator = 0;

	// 대여 정보 전체를 저장하는 mapping
	mapping(uint => RentalInfo) rentalInfoMap;
	uint rentedCount = 0;

	// 대여 계약시 발생되는 이벤트
	event BorrowEvent(uint id);
	// 계약 취소시 발생되는 이벤트
	event CancelEvent(uint id);
	// 수수료 변경시 발생되는 이벤트
	event ChangeFeeEvent(string feeName, uint fee);

	constructor () public {
		// 초기데이터 적제
		RentalInfo memory rentalInfo1;
		rentalInfo1.id = ++idGenerator;
		rentalInfo1.lender = msg.sender;
		rentalInfo1.deposit = 1000000000000000000;
		rentalInfo1.rentalFee = 1000000000000000000;
		rentalInfo1.systemFee = 1000000000000000000;
		rentalInfo1.isRented = false;
		rentalInfoMap[rentalInfo1.id] = rentalInfo1;
		// 초기데이터 적제
		RentalInfo memory rentalInfo2;
		rentalInfo2.id = ++idGenerator;
		rentalInfo2.lender = msg.sender;
		rentalInfo2.deposit = 1000000000000000000;
		rentalInfo2.rentalFee = 1000000000000000000;
		rentalInfo2.systemFee = 1000000000000000000;
		rentalInfo2.isRented = false;
		rentalInfoMap[rentalInfo2.id] = rentalInfo2;
		// 초기데이터 적제
		RentalInfo memory rentalInfo3;
		rentalInfo3.id = ++idGenerator;
		rentalInfo3.lender = msg.sender;
		rentalInfo3.deposit = 1000000000000000000;
		rentalInfo3.rentalFee = 1000000000000000000;
		rentalInfo3.systemFee = 1000000000000000000;
		rentalInfo3.isRented = false;
		rentalInfoMap[rentalInfo3.id] = rentalInfo3;
		// 초기데이터 적제
		RentalInfo memory rentalInfo4;
		rentalInfo4.id = ++idGenerator;
		rentalInfo4.lender = msg.sender;
		rentalInfo4.deposit = 1000000000000000000;
		rentalInfo4.rentalFee = 1000000000000000000;
		rentalInfo4.systemFee = 1000000000000000000;
		rentalInfo4.isRented = false;
		rentalInfoMap[rentalInfo4.id] = rentalInfo4;
		// 초기데이터 적제
		RentalInfo memory rentalInfo5;
		rentalInfo5.id = ++idGenerator;
		rentalInfo5.lender = msg.sender;
		rentalInfo5.deposit = 1000000000000000000;
		rentalInfo5.rentalFee = 1000000000000000000;
		rentalInfo5.systemFee = 1000000000000000000;
		rentalInfo5.isRented = false;
		rentalInfoMap[rentalInfo5.id] = rentalInfo5;
		// 초기데이터 적제
		RentalInfo memory rentalInfo6;
		rentalInfo6.id = ++idGenerator;
		rentalInfo6.lender = msg.sender;
		rentalInfo6.deposit = 1000000000000000000;
		rentalInfo6.rentalFee = 1000000000000000000;
		rentalInfo6.systemFee = 1000000000000000000;
		rentalInfo6.isRented = false;
		rentalInfoMap[rentalInfo6.id] = rentalInfo6;
		// 초기데이터 적제
		RentalInfo memory rentalInfo7;
		rentalInfo7.id = ++idGenerator;
		rentalInfo7.lender = msg.sender;
		rentalInfo7.deposit = 1000000000000000000;
		rentalInfo7.rentalFee = 1000000000000000000;
		rentalInfo7.systemFee = 1000000000000000000;
		rentalInfo7.isRented = false;
		rentalInfoMap[rentalInfo7.id] = rentalInfo7;
		// 초기데이터 적제
		RentalInfo memory rentalInfo8;
		rentalInfo8.id = ++idGenerator;
		rentalInfo8.lender = msg.sender;
		rentalInfo8.deposit = 1000000000000000000;
		rentalInfo8.rentalFee = 1000000000000000000;
		rentalInfo8.systemFee = 1000000000000000000;
		rentalInfo8.isRented = false;
		rentalInfoMap[rentalInfo8.id] = rentalInfo8;
		// 초기데이터 적제
		RentalInfo memory rentalInfo9;
		rentalInfo9.id = ++idGenerator;
		rentalInfo9.lender = msg.sender;
		rentalInfo9.deposit = 1000000000000000000;
		rentalInfo9.rentalFee = 1000000000000000000;
		rentalInfo9.systemFee = 1000000000000000000;
		rentalInfo9.isRented = false;
		rentalInfoMap[rentalInfo9.id] = rentalInfo9;
		// 초기데이터 적제
		RentalInfo memory rentalInfo10;
		rentalInfo10.id = ++idGenerator;
		rentalInfo10.lender = msg.sender;
		rentalInfo10.deposit = 1000000000000000000;
		rentalInfo10.rentalFee = 1000000000000000000;
		rentalInfo10.systemFee = 1000000000000000000;
		rentalInfo10.isRented = false;
		rentalInfoMap[rentalInfo10.id] = rentalInfo10;
	}

	/**
	 * 책 등록시 호출되는 함수.
	 * 대여자가 보낸 transaction 의 value값을 시스템 수수료로 저장한다.
	 */
	function registerBookInfo(uint _deposit,
								uint _rentalFee) external payable returns (uint id_) {
		
		require(_deposit > 0, "invalid deposit");
		require(_rentalFee > 0, "invalid rentalFee");
		require(msg.value == SYSTEM_FEE, "invalid msg.value");

		// 책의 정보를 구조체로 만들어 mapping에 저장한다.
		RentalInfo memory rentalInfo;
		rentalInfo.id = ++idGenerator;
		rentalInfo.lender = msg.sender;
		rentalInfo.deposit = _deposit;
		rentalInfo.rentalFee = _rentalFee;
		rentalInfo.systemFee = msg.value;
		rentalInfo.isRented = false;

		rentalInfoMap[rentalInfo.id] = rentalInfo;
		
		// 저장된 id를 리턴
		id_ = rentalInfo.id;
	}

	/**
	 * 등록된 책들 중에 _id 인자값에 해당하는 책을 대여하는 함수
	 * 대출자의 트랜잭션중 value 값은 보증금과 대여수수료의 합과 일치해야한다.
	 */
	function borrowBook(uint _id) external payable returns (uint id_) {
		require(_id > 0, "invalid input id");
		require(rentalInfoMap[_id].id > 0, "invalid id value");
		require(!rentalInfoMap[_id].isRented, "the book has been rented");
		require(msg.value == (rentalInfoMap[_id].deposit + rentalInfoMap[_id].rentalFee), "msg.value is invalid");

		// mapping에 저장된 책의 정보중 대여자와 대여여부값을 수정한다.
		rentalInfoMap[_id].borrower = msg.sender;
		rentalInfoMap[_id].isRented = true;
		rentedCount++;

		// 대출 EVENT 알림
		emit BorrowEvent(rentalInfoMap[_id].id);

		// 저장한 id를 리턴
		id_ = rentalInfoMap[_id].id;
	}

	/**
	 * 대여자, 대출자가 거래를 취소하는 함수
	 * 취소 수수료가 있음
	 */
	function cancelRental(uint _id) external payable returns(uint id_) {
		require(_id > 0, "invalid input id");
		require(msg.value == CANCEL_FEE, "invalid msg.value");
		require(rentalInfoMap[_id].id > 0, "invalid id value");
		require(rentalInfoMap[_id].isRented, "the book hasn't been rented");

		// mapping에 저장된 책의 정보 중 _id에 해당하는 책에 대한 대여 신청을 취소한다.
		address payable borrower = rentalInfoMap[_id].borrower;
		rentalInfoMap[_id].borrower = address(0);
		rentalInfoMap[_id].isRented = false;
		uint refund = rentalInfoMap[_id].deposit + rentalInfoMap[_id].rentalFee;
		rentedCount--;

		// 계약 취소 "EVENT"
		emit CancelEvent(rentalInfoMap[_id].id);

		// 취소시 대출자가 지급한 보증금, 대여 수수료를 환불한다.
		borrower.transfer(refund);
		
		id_ = rentalInfoMap[_id].id;
	}

	/**
	 * _id에 해당하는 RentalInfo를 조회하는 함수
	 * 외부뿐만 아니라 내부에서도 호출할 수 있기때문에 public으로 구현
	 */
	function getRentalInfo(uint _id) public view returns (uint id_,
																address lender_,
																address borrower_,
																uint deposit_,
																uint rentalFee_,
																uint systemFee_,
																bool isRented_) {
		require(_id > 0, "invalid input id");
		require(rentalInfoMap[_id].id > 0, "invalid id value");

		id_ = rentalInfoMap[_id].id;
		lender_ = rentalInfoMap[_id].lender;
		borrower_ = rentalInfoMap[_id].borrower;
		deposit_ = rentalInfoMap[_id].deposit;
		rentalFee_ = rentalInfoMap[_id].rentalFee;
		systemFee_ = SYSTEM_FEE;
		isRented_ = rentalInfoMap[_id].isRented;
	}

	/**
	 * 정상 반납을 위한 함수
	 * 대여 수수료는 대여자에게 보증금은 대출자에게 환불한다.
	 */
	function returnedBook(uint _id) external returns(uint id_) {
		require(_id > 0, "invalid input id");
		require(rentalInfoMap[_id].id > 0, "invalid id value");
		require(rentalInfoMap[_id].isRented, "the book hasn't been rented");
		require(rentalInfoMap[_id].lender == msg.sender, "invalid msg.sender");

		// mapping에 저장된 책의 정보 중 _id에 해당하는 책에 대한 정보를 반납 처리한다.
		address payable borrower = rentalInfoMap[_id].borrower;
		rentalInfoMap[_id].borrower = address(0);
		rentalInfoMap[_id].isRented = false;
		rentedCount--;

		// 대여 수수료를 대여자에게 지급한다.
		msg.sender.transfer(rentalInfoMap[_id].rentalFee);
		// 대출자가 지급한 보증금을 환불한다.
		borrower.transfer(rentalInfoMap[_id].deposit);
		// 시스템 수수료를 소유자에게 지급한다.
		owner.transfer(rentalInfoMap[_id].systemFee);

		id_ = rentalInfoMap[_id].id;
	}

	/**
	 * 비정상 반납을 위한 함수
	 * 대여 수수료 + 보증금은 대여자에게 지급한다.
	 */
	function returnedBookInAbnormal(uint _id) external returns(uint id_) {
		require(_id > 0, "invalid input id");
		require(rentalInfoMap[_id].id > 0, "invalid id value");
		require(rentalInfoMap[_id].isRented, "the book hasn't been rented");
		require(rentalInfoMap[_id].lender == msg.sender, "invalid msg.sender");

		// mapping에 저장된 책의 정보 중 _id에 해당하는 책에 대한 정보를 반납 처리한다.
		rentalInfoMap[_id].borrower = address(0);
		rentalInfoMap[_id].isRented = false;
		uint refund = rentalInfoMap[_id].deposit + rentalInfoMap[_id].rentalFee;
		rentedCount--;

		// 대여 수수료 + 보증금을 대여자에게 지급한다.
		msg.sender.transfer(refund);
		// 시스템 수수료를 소유자에게 지급한다.
		owner.transfer(rentalInfoMap[_id].systemFee);

		id_ = rentalInfoMap[_id].id;
	}

	/**
	 * 연체 반납을 위한 함수
	 * 대여 수수료 + 연체 수수료는 대여자에게 지급한다.
	 * 보증금 - 연체 수수료는 대출자에게 환불한다.
	 */
	function returnedBookWithLateFee(uint _id, uint _lateFee) external returns(uint id_) {
		require(_id > 0, "invalid input id");
		require(rentalInfoMap[_id].id > 0, "invalid id value");
		require(rentalInfoMap[_id].isRented, "the book hasn't been rented");
		require(rentalInfoMap[_id].lender == msg.sender, "invalid msg.sender");

		// mapping에 저장된 책의 정보 중 _id에 해당하는 책에 대한 정보를 반납 처리한다.
		address payable borrower = rentalInfoMap[_id].borrower;
		rentalInfoMap[_id].borrower = address(0);
		rentalInfoMap[_id].isRented = false;
		uint amountToLender = _lateFee + rentalInfoMap[_id].rentalFee;
		uint amountToBorrower = rentalInfoMap[_id].deposit - _lateFee;
		rentedCount--;

		// 대여 수수료 + 보증금을 대여자에게 지급한다.
		msg.sender.transfer(amountToLender);
		// 보증금 - 연체료를 대출자에게 지급한다.
		borrower.transfer(amountToBorrower);
		// 시스템 수수료를 소유자에게 지급한다.
		owner.transfer(rentalInfoMap[_id].systemFee);

		id_ = rentalInfoMap[_id].id;
	}

	/**
	 * 시스템 사용 수수료를 조절하는 함수.
	 * 단위 : wei
	 */
	function setSystemFee(uint _systemFee) public {
		SYSTEM_FEE = _systemFee;
		emit ChangeFeeEvent("SYSTEM_FEE", SYSTEM_FEE);
	}

	/**
	 * 시스템 사용 수수료를 조회하는 함수.
	 * 단위 : wei
	 */
	function getSystemFee() public view returns(uint systemFee_) {
		systemFee_ = SYSTEM_FEE;
	}

	/**
	 * 취소 수수료를 조절하는 함수.
	 * 단위 : wei
	 */
	function setCancelFee(uint _cancelFee) public {
		CANCEL_FEE = _cancelFee;
		emit ChangeFeeEvent("CANCEL_FEE", CANCEL_FEE);
	}

	/**
	 * 취소 수수료를 조회하는 함수.
	 * 단위 : wei
	 */
	function getCancelFee() public view returns(uint cancelFee_) {
		cancelFee_ = CANCEL_FEE;
	}

	/**
	 * 계약서 소유자가 시스템 수수료를 인출하는 함수.
	 */
	function withdrawSystemFee() public {
		// 계약 오너에게 시스템 수수료를 전부 제공한다.
		require(msg.sender == owner, "invalid msg.sender");

		owner.transfer(address(this).balance);
	}

	function getRentedBook () public view returns(uint[] memory ids_) {
		ids_ = new uint[](rentedCount);
		uint rentedIdx = 0;
		for(uint i = 0 ; i < idGenerator ; i++) {
			if(rentalInfoMap[i].isRented) {
				ids_[rentedIdx++] = i;
			}
		}
	}
}