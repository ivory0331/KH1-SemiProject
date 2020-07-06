show user;
-- USER이(가) "SEMIORAUSER1"입니다.

select * FROM tab;

drop table review_image_table;
drop table review_table;
drop table order_product_table;
drop table one_inquiry_table;
drop table one_category_table;
drop table order_table;
drop table order_state_table;
drop table product_inquiry_image_table;
drop table product_inquiry_table;
drop table product_image_table;
drop table basket_table;
drop table product_table;
drop table product_category_table;
drop table product_subcategory_table;
drop table notice_table;
drop table FAQ_table;
drop table inquiry_category_table;
drop table member_table;


-- 회원 테이블 --
create table member_table
(member_num number  not null -- 회원번호 필수입력 + 유일한 값(primary) + 시퀀스 사용
,name       varchar2(30) not null -- 성명 필수입력
,userid     varchar2(50) not null -- 유저id 필수입력 + 유일한 값
,pwd        varchar2(300) not null -- 암호 필수입력 (SHA-256 암호화 대상)
,email      varchar2(300) not null -- 이메일(암호화) 필수입력 + 유일한 값
,mobile       varchar2(30) not null -- 핸드폰 번호 (암호화)
,postcode   varchar2(100) -- 우편번호
,address    varchar2(200) -- 주소
,detailAddress  varchar2(100) -- 상세주소
,gender     number(1) -- 성별
,birthday   varchar2(8) -- 생년월일
,registerdate date default sysdate -- 가입날짜
,pwd_change_date date default sysdate -- 암호 수정한 날짜 
,last_login_date date default sysdate -- 마지막 로그인 날짜
,status     number(1) default 1 -- 회원상태(일반회원, 관리자, 휴면상태)
,constraint pk_member_table PRIMARY KEY (member_num)
,constraint uq_member_table_userid UNIQUE(userid)
,constraint uq_member_table_email unique(email)
,constraint ck_member_table_gender CHECK (gender in (0,1,2))
,constraint ck_member_table_status CHECK (status in(0,1,2))
);




drop sequence seq_member_table;
-- 회원테이블에 사용할 시퀀스 생성 --
create sequence seq_member_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 관리자 계정으로 변환
update member_table set status=2 where member_num=1;

commit;


-- 상품 대분류 카테고리 테이블 생성 --
create table product_category_table
( category_num  number            -- 대분류 카테고리 번호 필수+고유
, category_content  varchar2(50)  -- 번호에 해당하는 실제 표시할 내용
,constraint pk_category_num primary key (category_num)
);


insert into product_category_table(category_num, category_content) values(1,'채소');
insert into product_category_table(category_num, category_content) values(2,'과일 견과');
insert into product_category_table(category_num, category_content) values(3,'수산 해산');
insert into product_category_table(category_num, category_content) values(4,'정육');
insert into product_category_table(category_num, category_content) values(5,'음료 우유');
commit;



-- 상품 소분류 카테고리 테이블 생성 --
create table product_subcategory_table
(subcategory_num    number  -- 소분류 카테고리 번호 필수+고유
,subcategory_content varchar2(50) -- 번호에 해당하는 실제 표시할 내용
,constraint pk_product_subcategory_table primary key (subcategory_num)
);




insert into product_subcategory_table(subcategory_num, subcategory_content) values(11,'기본채소');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(12,'쌈 샐러드');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(13,'특수채소');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(21,'국산과일');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(22,'수입과일');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(23,'냉동 건과일');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(31,'생선류');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(32,'오징어 낙지 문어');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(33,'새우 게 랍스타');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(41,'소고기');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(42,'돼지고기');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(43,'닭 오리고기');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(51,'생수 음료 주스');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(52,'커피 차');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(53,'우유 두유 요거트');
commit;



  
-- 상품 테이블 생성 --
create table product_table
(product_num    number not null -- 상품번호 필수+고유 시퀀스 사용
,product_name   varchar2(200) not null -- 상품이름 필수+고유
,price          number  not null -- 가격 필수
,stock          number not null -- 재고 필수
,weight         varchar2(200)   -- 중량/용량
,origin         varchar2(100) -- 원산지
,packing      varchar2(80) -- 포장방법
,unit           varchar2(50) -- 단위
,shelf          varchar2(100) -- 유통기한
,information    varchar2(500) -- 안내사항
,registerdate   date default sysdate -- 등록날짜
,sale           number default 0 -- 세일 %값
,best_point     number default 0 -- 관리자가 추천하는 수 (MD추천)
,seller         varchar2(50) -- 판매자(관리자 모드시에 사용)
,seller_phone   varchar2(80) -- 판매자 번호(관리자 모드시에 사용)
,explain    varchar2(4000) -- 상품설명
,representative_img varchar2(200) not null
,fk_category_num    number not null -- product_category_table에 있는 category_num을 참조하는 컬럼
,fk_subcategory_num number not null -- product_subcategory_table에 있는 subcategory_num을 참조하는 컬럼
,constraint pk_product_table primary key (product_num)
,constraint uq_product_product_name   unique (product_name)
,constraint fk_product_category_num FOREIGN key(fk_category_num) REFERENCES product_category_table(category_num) on delete cascade
,constraint fk_product_subcategory_num FOREIGN key(fk_subcategory_num) REFERENCES product_subcategory_table(subcategory_num) on delete cascade
);



commit;

drop  sequence seq_product_table;

-- 상품 테이블에 사용할 시퀀스 생성 --
create sequence seq_product_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


drop table product_image_table;

-- 상품 이미지와 설명 테이블 생성 --

create table product_image_table
(product_image_num number not null
,fk_product_num number not null -- 상품테이블에 있는 상품번호를 참조받는 컬럼
,image  varchar2(200)
,constraint pk_product_image_table primary key (product_image_num)
,constraint fk_prodcut_detail_num FOREIGN key (fk_product_num) REFERENCES product_table(product_num) on DELETE CASCADE
);


drop sequence seq_product_image;
-- 상품 이미지에서 사용할 시퀀스 -- 
create sequence seq_product_image
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



-- 상품문의 테이블 생성 --
create table product_inquiry_table
(inquiry_num    number not null     -- 상품문의 번호 필수+고유 시퀀스 사용
,subject    varchar2(100) not null   -- 제목 필수
,content    varchar2(4000) not null -- 내용 필수
,write_date date default sysdate    -- 작성날짜 
,answer     varchar2(4000)          -- 관리자의 답변(문의가 들어오면 바로 답변을 받는 것이 아니기에 null허용)
,answer_date date                   -- 관리자 답변 작성 날짜
,fk_member_num  number not null     -- 회원테이블의 회원번호를 참조받는 컬럼 필수(참조하는 값이 삭제되면 따라서 삭제됨)
,fk_product_num number not null     -- 상품테이블의 회원번호를 참조받는 컬럼 필수(참조하는 값이 삭제되면 따라서 삭제됨)
,emailFlag      number(1) default 0 -- 이메일로 답변 받고자 하는지 판단하는 컬럼
,smsFlag        number(1) default 0 -- 문자로 답변 받고자 하는지 판단하는 컬럼
,secretFlag     number(1) default 0 -- 비밀글로 하고자 하는지 판단하는 컬럼
,constraint pk_product_inquiry primary key(inquiry_num)
,constraint fk_inquiry_member FOREIGN key(fk_member_num) REFERENCES member_table(member_num)on delete CASCADE
,constraint fk_inquiry_product foreign key(fk_product_num) REFERENCES product_table(product_num)on delete cascade
,constraint ck_emailFlag check (emailFlag in(0,1))
,constraint ck_smsFlag check (smsFlag in(0,1))
,constraint ck_secretFlag check (secretFlag in(0,1))
);

drop sequence seq_product_inquiry;
-- 상품문의 테이블에 사용할 시퀀스 생성 --
create sequence seq_product_inquiry
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 상품문의 이미지 테이블 --
create table product_inquiry_image_table
(fk_inquiry_num number not null
,image varchar2(100)
,constraint fk_inquiry_image FOREIGN key (fk_inquiry_num) REFERENCES product_inquiry_table(inquiry_num) on delete CASCADE
);





-- 배송상테 테이블 생성 --
create table order_state_table
(category_num   number  not null -- 배송상태 카테고리 번호 (1:상품준비중, 2:배송중, 3:배송완료)
,order_state    varchar2(50) -- 번호에 해당하는 실제 내용
,constraint pk_order_state  primary key(category_num)
);

insert into order_state_table(category_num, order_state) values(0, '상품준비중');
insert into order_state_table(category_num, order_state) values(1, '상품출하');
insert into order_state_table(category_num, order_state) values(2, '배송중');
insert into order_state_table(category_num, order_state) values(3, '배송완료');

commit;






-- 주문 정보 테이블 생성 --
create table order_table
(order_num  number  not null    -- 주문번호 필수+고유 시퀀스 사용
,order_date date default sysdate    -- 주문날짜
,recipient  varchar2(50) not null   -- 받는 사람 필수
,recipient_mobile   varchar2(100) not null  -- 받는 사람의 연락처 필수
,recipient_postcode varchar2(100) not null  -- 받는 사람의 우편번호
,recipient_address  varchar2(200) not null  -- 받는 사람의 주소
,recipient_detailaddress varchar2(200) not null -- 받는 사람의 상세주소
,price  number  not null    -- 주문금액 필수
,memo   varchar2(200)       -- 요청사항
,fk_member_num  number      -- 회원테이블의 회원번호를 참조하는 컬럼
,fk_category_num number default 0 not null    -- 주문상태 테이블의 주문상태 번호를 참조하는 컬럼
,constraint pk_order_table  primary key(order_num)
,constraint fk_order_member FOREIGN key(fk_member_num) REFERENCES member_table(member_num) on delete set null
,constraint fk_order_category foreign key(fk_category_num) references order_state_table(category_num) 
);







-- 주문 상품 정보 테이블 (주문번호 1)
insert into order_product_table(product_count, fk_order_num, fk_product_num, price, reviewFlag)
values(1,1,69,12900,0);
insert into order_product_table(product_count, fk_order_num, fk_product_num, price, reviewFlag)
values(2,1,70,45500,0);

insert into order_product_table(product_count, fk_order_num, fk_product_num, price, reviewFlag)
values(1,2,146,3980,0);
insert into order_product_table(product_count, fk_order_num, fk_product_num, price, reviewFlag)
values(1,2,147,3810,0);

insert into order_product_table(product_count, fk_order_num, fk_product_num, price, reviewFlag)
values(1,2,150,1000,0);
insert into order_product_table(product_count, fk_order_num, fk_product_num, price, reviewFlag)
values(1,2,151,2000,0);
insert into order_product_table(product_count, fk_order_num, fk_product_num, price, reviewFlag)
values(1,2,152,3000,0);

commit;

drop sequence seq_order_table;
-- 주문 테이블에 사용할 시퀀스 생성 --
create sequence seq_order_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 주문상품 테이블 생성 --
create table order_product_table
(product_count  number not null -- 주문한 상품의 갯수 필수
,fk_order_num   number not null -- 주문정보 테이블의 주문번호를 참조하는 컬럼
,fk_product_num number          -- 상품테이블의 상품번호를 참조하는 컬럼
,price          number not null -- 주문상품의 가격(할인 후)
,reviewFlag     number(1) default 0
,constraint fk_order FOREIGN key (fk_order_num) REFERENCES order_table(order_num) on delete cascade
,constraint fk_product FOREIGN key (fk_product_num ) REFERENCES product_table(product_num) on delete set null
,constraint ck_reviewFlag check (reviewFlag in (0,1))
);



create table review_table
(review_num number not null -- 후기 번호 필수+고유 시퀀스 사용
,subject    varchar2(100) not null -- 후기 제목  필수
,content    varchar2(4000) not null -- 후기 내용 필수
,write_date date default sysdate -- 작성 날짜
,hit        number default 0 -- 조회수
,favorite   number default 0 -- 좋아요 수
,fk_product_num number not null -- 상품테이블에서 상품번호를 참조하는 컬럼 -- 두 개의 컬럼을 복합해서 유니크 키로 제약 
,fk_order_num   number          -- 주문테이블에서 주문번호를 참조하는 컬럼 --
,fk_member_num  number          -- 회원테이블에서 회원번호를 참조하는 컬림
,constraint pk_review_table primary key (review_num)
,constraint fk_review_order FOREIGN key (fk_order_num) REFERENCES order_table(order_num) on delete set null
,constraint fk_review_product FOREIGN key (fk_product_num) REFERENCES product_table(product_num) on delete CASCADE
,constraint fk_review_member FOREIGN key (fk_member_num) REFERENCES member_table(member_num) on delete cascade
,constraint uq_review_orderProduct UNIQUE (fk_product_num, fk_order_num)
);

drop sequence seq_review_table;
-- 리뷰테이블에 사용할 시퀀스 생성 --
create sequence seq_review_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 후기테이블용 이미지 테이블 생성 --
create table review_image_table
(fk_review_num number not null
,image varchar2(100)
,constraint fk_review_image FOREIGN key (fk_review_num) REFERENCES review_table(review_num)on delete cascade
);






-- 1:1문의 카테고리 테이블 생성 --
create table one_category_table
(category_num   number not null
,category_content varchar2(50)
,constraint pk_one_category primary key (category_num)
);

insert into one_category_table(category_num, category_content) values(1, '배송지연/불만');
insert into one_category_table(category_num, category_content) values(2, '컬리패스(무료배송)');
insert into one_category_table(category_num, category_content) values(3, '반품문의');
insert into one_category_table(category_num, category_content) values(4, 'A/S문의');
insert into one_category_table(category_num, category_content) values(5, '환불문의');
insert into one_category_table(category_num, category_content) values(6, '주문결제문의');
insert into one_category_table(category_num, category_content) values(7, '회원정보문의');
insert into one_category_table(category_num, category_content) values(8, '취소문의');
insert into one_category_table(category_num, category_content) values(9, '교환문의');
insert into one_category_table(category_num, category_content) values(10, '상품정보문의');
insert into one_category_table(category_num, category_content) values(11, '기타문의');

commit;



-- 1:1문의 테이블 생성 --
create table one_inquiry_table
(one_inquiry_num number not null    -- 1:1문의 게시글 번호
,subject    varchar2(50) not null   -- 문의 제목 필수
,content    varchar2(4000) not null -- 문의 내용 필수
,write_date date default sysdate    -- 작성날짜
,answer     varchar2(4000)          -- 관리자가 작성하는 답변
,answer_date date                   -- 관리자가 답변한 날짜
,emailFlag  number default 0
,smsFlag    number default 0
,fk_member_num  number not null     -- 회원테이블에서 회원번호를 참조하는 컬럼
,fk_order_num   number     -- 주문테이블에서 주문번호를 참조하는 컬럼
,fk_category_num number not null    -- 1:1문의 카테고리 테이블에서 카테고리번호를 참조하는 컬럼
,constraint pk_one_inquiry primary key (one_inquiry_num)
,constraint fk_one_member FOREIGN key (fk_member_num) REFERENCES member_table(member_num) on delete cascade
,constraint fk_one_category FOREIGN key (fk_category_num) REFERENCES one_category_table(category_num) on delete set null
,constraint ck_one_emailCheck   check (emailFlag in(0,1))
,constraint ck_one_smsCheck check (smsFlag in (0,1))
);



drop sequence seq_one_inquiry_table;
-- 1:1문의 테이블에서 사용할 시퀀스 생성 --
create sequence seq_one_inquiry_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 공지사항 테이블 생성 --
create table notice_table
(notice_num number not null
,subject    varchar2(200) not null
,content    varchar2(4000) not null
,write_date date default sysdate
,hits   number default 0
,constraint pk_notice_table primary key (notice_num)
);

drop sequence seq_notice_table;
-- 공지사항 테이블에 사용할 시퀀스 생성 --
create sequence seq_notice_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 자주하는 질문 카테고리 테이블 생성 --
create table inquiry_category_table
(category_num   number not null
,category_content   varchar2(50)
,constraint pk_inquiry_category primary key (category_num)
);

insert into inquiry_category_table(category_num, category_content) values(1, '회원문의');
insert into inquiry_category_table(category_num, category_content) values(2, '주문/결제');
insert into inquiry_category_table(category_num, category_content) values(3, '배송문의');
insert into inquiry_category_table(category_num, category_content) values(4, '서비스 이용 및 기타');

commit;



-- 자주하는 질문 테이블 생성 --
create table FAQ_table
(FAQ_num number not null
,subject varchar2(200) not null
,content varchar2(4000) not null
,write_date date default sysdate
,hits   number default 0
,fk_category_num    number not null
,constraint pk_FAQ_table primary key(FAQ_num)
,constraint fk_FAQ_category FOREIGN key(fk_category_num) REFERENCES inquiry_category_table(category_num) on delete cascade
);



drop sequence seq_FAQ_table;

-- 자주하는 질문 테이블에서 사용할 시퀀스 생성 --
create sequence seq_FAQ_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;




-- 장바구니 테이블 --
create table basket_table
(basket_num     number not null
,product_count  number not null -- 주문한 상품의 갯수 필수
,fk_member_num  number not null -- 해당 장바구니에 상품을 담은 회원
,fk_product_num number not null -- 상품테이블의 상품번호를 참조하는 컬럼
,constraint fk_basket_product FOREIGN key (fk_product_num ) REFERENCES product_table(product_num) on delete cascade
,constraint fk_basket_member FOREIGN key (fk_member_num) REFERENCES member_table (member_num) on delete cascade
,constraint pk_basket_num primary key (basket_num)
);


drop sequence seq_basket_table;
-- 장바구니 테이블에 사용할 시퀀스 생성 --
create sequence seq_basket_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;




desc product_table;
/*
이름                 널?       유형             
------------------ -------- -------------- 
PRODUCT_NUM        NOT NULL NUMBER         
PRODUCT_NAME       NOT NULL VARCHAR2(200)  
PRICE              NOT NULL NUMBER         
STOCK              NOT NULL NUMBER  
WEIGHT                      VARCHAR2(200)
ORIGIN                      VARCHAR2(100)  
PACKING                     VARCHAR2(80)   
UNIT                        VARCHAR2(50)   
SHELF                       VARCHAR2(100)  
INFORMATION                 VARCHAR2(500)  
REGISTERDATE                DATE           
SALE                        NUMBER         
BEST_POINT                  NUMBER         
SELLER                      VARCHAR2(50)   
SELLER_PHONE                VARCHAR2(80)   
EXPLAIN                     VARCHAR2(4000) 
REPRESENTATIVE_IMG NOT NULL VARCHAR2(200)  
FK_CATEGORY_NUM    NOT NULL NUMBER         
FK_SUBCATEGORY_NUM NOT NULL NUMBER   

*/

-- 소고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, shelf, information, sale, best_point, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img, explain) 
values(seq_product_table.nextval, '1등급 한우 갈빗살 구이용 200g(냉장)', '31000', '1000', '국내산(한우)', '냉장/종이포장','1팩', '포장일로부터 최소5일 이내 제품을 보내드립니다.',
'본 제품은 알레르기를 유발할 수 있습니다.<br>비닐 포장 등에 의해 산소가 공급되지 않아 간혹 검붉게 변하는 현상이 발생할 수 있으나, 산소와 접촉하면 선홍색으로 돌아오는 점 안내드립니다.', '10','5', '김진하', '01075653393', 4, 41, '1등급 한우 갈빗살 구이용 200g(냉장).png'
,'컬리가 좋은 소식처럼 들려드리고 싶은 소고기, 소식의 1등급 한후 갈빗살 구이용을 만나보세요. 
소식은 전국 최대 도축물량을 자랑하는 음성축산공판장에서 선별을 마친 고기를 즉시 가공하는데요.
엄선한 1등급 한우의 갈빗살을 정육해 담았답니다. 냉동하지 않은 냉장 제품으리 고기의 육즙이 그대로 보존돼 있어요. 
살코기와 지방의 균형이 좋아 씹는 맛이 좋고 감칠맛도 뛰어납니다.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,explain) 
values(seq_product_table.nextval, '1등급 한우 목심 샤브샤브용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '1등급 한우 목심 샤브샤브용 200g(냉장).png'
,'보글보글 끓는 국물에 살짝살짝 익혀 먹기에 꼭 알맞은 목심을 만나보세요. 얇게 저며냈지만 1+등급의 한우답게 기름지지 않으면서도 적당한 육즙을 머금고 있는 제품이랍니다.
200g을 한 팩에 담아 1인 가구가 근사한 한 끼를 먹기에도 적당할 거에요. 버섯, 알배추, 쑥갓 등의 채소를 더한 뒤 취향에 따라 생 고추냉이,참깨 드레싱, 간장 등을 곁들여 즐겨보세요.');

insert into product_table (product_num, product_name, price, stock, origin, packing, weight, unit, shelf, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,information, explain) 
values(seq_product_table.nextval, '1등급 한우 안심 추리 150g(냉장)', '35000', '4000', '국내산(한우)', '냉장/종이포장','150g', '1팩',
'포장일로부터 최소 7일 이내 제품을 보내드립니다.', '0', '김진하', '01075653393', 4, 41, '1등급 한우 안심 추리 200g(냉장).png'
,'해당 상품은 냉장 상품입니다. 비닐포장등에 의해 산소가 공급되지 않아 간혹 검붉게 변하는 현상이 발생할 수 있으나 산소와 접촉하면 선홍색으로 돌아오는 점 안내드립니다.'
,'프리미엄 한우를 논할 때 마블링 등급, 다채로운 부위, 충분한 숙성은 빠질 수 없는 중요한 요소입니다. 이번에 소개하는 추리모둠은 등심과 안심, 채끝의 추리를 모은 상품이에요.
추리는 고기 덩어리 주변에 있는 띠 모양의 근육으로 가장 자리에 붙은 부산물로 취급받곤 해요. 사실 추리 부분을 어떻게 손질하느냐에 따라 맛과 식감이 달라져 미식가에게 인기 있는 부위이기도 해요.
PPUL은 등심과 안심, 채끝 추리 주변에 있는 얇은 근막과 불필요한 지방을 섬세하게 제거해 살코기만 남겼어요. 추리 본연의 진한 육항, 야들야들하면서도 쫄깃한 식감을 제대로 맛볼 수 있어요.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img, weight, shelf, explain) 
values(seq_product_table.nextval, '1등급 한우 알사태 수육용 500g(냉장)', '34000', '6', '국내산(한우)', '냉장/종이포장', '1팩', '20', '김진하', '01075653393', 4, 41, '1등급 한우 알사태 수육용 500g(냉장).png'
,'500g','포장일로부터 최소 5일 이내 제품을 보내 드립니다.','컬리가 좋은 소식처럼 들려드리고 싶은 소고기, 소식의 1등급 한우 알사태 수육용을 만나보세요. 
소식은 전국 최대 도축물량을 자랑하는 음성축산공판장에서 선별을 마친 고기를 즉시 가공하는데요.사태는 지방이 적은 대표적인 부위로, 삶을수록 먹기 좋게 쫀쫀해져요. 먹기 좋게 잘라 수육으로 먹거나 간장에 졸여 장조림을 만들어도 좋습니다.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img, weight, information, explain) 
values(seq_product_table.nextval, '[태우한우]1등급 한우 채끝 스키야끼용 200g(냉장)', '30000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '1등급 한우 채끝 스키야끼용 200g(냉장).png'
,'200g','중량에 따라 작은 조각이 함께 포장될 수 있습니다.보관기간이 신선도에 많은 영향을 주는 정육식품이기 때문에 수령후 최대한 빠른 시일내에 섭취를 권장드립니다.'
,'스키야키는 일본을 대표하는 소고기 요리 중 하나입니다. 간장과 설탕을 섞어 만든 소스에 얇게 썬 소고기, 갖은 야채, 두부, 실곤약 등의 재료를 넣고 자작하게 끓여서 목죠.
짭짤하면서도 달콤한 간이 배도록 만들기 때문에 지방과 살코기의 함량이 적절하게 섞인 부위를 사용하는게 좋아요. 태우한우는 감칠맛이 뛰어난 채끝으로 스키야키용 고기를 선보여요.
고기의 결이 고우면서도 씹는 맛이 좋고, 마블링이 적당해 스키야키로 요리하면 부드러운 풍미로 즐길 수 있습니다.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img, weight, shelf, information, explain) 
values(seq_product_table.nextval, '1등급 한우 홍두깨 육전용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '1등급 한우 홍두깨 육전용 200g(냉장).png'
,'200g','포장일로부터 최소 3일 이내 제품을 보내드립니다.','해당 상품은 냉장 제품입니다. 정육 상품의 특성상 3% 내외 중량 차이가 발생할 수 있습니다.'
,'컬리가 좋은 소식처럼 들려드리고 싶은 소고기, 소식의 1등급 한우 홍두깨 육전용을 만나보세요. 엄선한 1등급 한우의 홍두깨살로 육전을 만들어 보세요.
고소한 기름맛 감도는 육전은 아이들 밥반찬으로도 더할 나위 없어요. 고추기름 낸 육개장에 푸짐하게 넣어 해장국을 만들어도 좋겠죠.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,explain) 
values(seq_product_table.nextval, '와규 MB4+안심 스테이크 200g(냉장)', '33000', '500', '호주산', '냉장/종이포장', '1팩', '10', '김진하', '01075653393', 4, 41, '와규 MB4+안심 스테이크 200g(냉장).png'
,'본래 일본의 소 품종을 일컫는 말인 와규는 현재 고급 소기기의 대명사로 통합니다. 마블링이 발달해서 육즙이 풍부하고 고기 본연의 감칠맛이 뛰어냐죠.
부드러운 교깃결 덕분에 알맞게 조리하면 입 안에서 사르르 녹는 즐거움을 안겨줄 거에요. 고기 본연의 맛을 가장 잘 드러낼 수 있도록 구워서 드시길 추천해요.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,explain) 
values(seq_product_table.nextval, '와규 MB4+채끝 스테이크 200g(냉장)', '33000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 4, 41, '와규 MB4+채끝 스테이크 200g(냉장).png'
,'본래 일본의 소 품종을 일컫는 말인 와규는 현재 고급 소고기의 대명사로 통합니다. 마블링이 발달해서 육즙이 풍부하고 고기 본연의 감칠맛이 뛰어나죠.
등심보다 부드럽고 안심보다는 식감이 있는 채끝 스테이크를 선보입니다. 마블링이 적당하게 분포해서 구웠을 때 입안 가득 퍼지는 고소한 육즙과 풍성한 식감이 일품이죠.
특별한 식사를 즐기고 싶은 날, 도톰한 채끝을 달궈진 팬에서 알맞게 구워 만찬을 즐겨보세요.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,weight,explain ) 
values(seq_product_table.nextval, '초이스 찜갈비 2kg(냉동)', '58000', '505', '미국산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '초이스 찜갈비 2kg(냉동).png','1.6kg'
,'양념이 고루 밴 쫄깃한 갈비찜은 언제 먹어도 좋은 한 그릇 요리지요. 어떤 갈비를 선택할까 고민하고 있다면 초이스 찜갈비를 추천드려요.
미국산 소고기 중에서도 상위 등급인 초이스 등급의 고품질 찜갈비. 부드러운 육질은 물론이고요. 불필요한 지방을 알맞게 제거했기에 더욱 깔끔하게 즐길 수 있답니다.
달큰한 양념과 다양한 야채를 더해 푸짐한 갈비찜 한 그릇을 요리해 보세요.');

commit;

select * from product_table where fk_category_num=4;

desc product_image_table;
/*
FK_PRODUCT_NUM NOT NULL NUMBER        
IMAGE                   VARCHAR2(200) 
*/
-- 상세 이미지 --
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,9,'10번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,9,'10번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,9,'10번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,8,'9번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,8,'9번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,8,'9번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,7,'8번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,7,'8번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,7,'8번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,6,'7번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,6,'7번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,6,'7번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,5,'6번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,5,'6번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,5,'6번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,4,'5번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,4,'5번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,4,'5번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,3,'4번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,3,'4번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,3,'4번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,2,'3번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,2,'3번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,2,'3번상품03이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,1,'2번상품01이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,1,'2번상품02이미지.png');
insert into product_image_table(product_image_num ,fk_product_num, image)values(seq_product_image.nextval,1,'2번상품03이미지.png');

commit;
select * from product_image_table order by product_image_num asc; 



-- 돼지고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,explain) 
values(seq_product_table.nextval, '국내산 목살 양념구이', '12900', '800', '국내산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 4, 42, '국내산 목살 양념구이.png'
,'양념된 돼지고기 하면 갈비 부위를 먼저 떠올리실 텐데요. 갈비가 아닌 목살 부위를 엄선한 뒤 마늘,배,양파,설탕,생강 등으로 만든 특제 간장 양념을 입혔습니다.
목살은 갈비보다 기름기가 적고 살코기의 품질을 유지하기에도 좋기 때문이지요. 양념 목살의 표면을 보면 사선으로 촘촘히 선이 새겨져 있는 것을 알 수 있습니다.
기계가 아닌 사람의 손이 일일이 칼집을 넣어 육질을 부드럽게 만든 흔적이에요. 돼지 양념 목살을 집에서 노릇노릇하게 구워 드셔보세요.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,weight, information, explain) 
values(seq_product_table.nextval, '매콤한맛 삼겹살구이 (냉동)', '4900', '100', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 4, 42, '매콤한맛 삼겹살구이 (냉동).png'
,'320g','대두, 밀이 함유가 되어있습니다. 알레르기를 유발할 수 있다는 점을 안내드립니다.'
,'라면 끓이듯 간편하게 양념 삼겹살을 만들어 보세요. 컬리가 소개하는 돈쉐이크 삼겹살구이는 양념구이가 얼마나 쉬울 수 있는지 보여줍니다. 패키지를 열고, 동봉된 시즈닝을 패키지 안에 뿌린 뒤 고기와 잘 흔들어주세요.
그리고 팬이나 에어프라이어에 구워내면 완성입니다. 매콤한 맛 시즈닝을 뿌리면 양념맛이 살아있는 삼겹살구이가 완성됩니다. 후끈하게 매운 맛은 아니어서 부담없이 먹을 수 있이요.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,weight,information,best_point, explain) 
values(seq_product_table.nextval, '[태우한우]무한생제 1등급 한동 다짐육 300g(냉장)', '58000', '500', '국내산', '냉장/종이포장', '1팩', '5', '김진하', '01075653393', 4, 42,  '무한생제 1등급 한동 다짐육 300g(냉장).png'
,'300g(30gX10)','해당 상품은 냉동 상품입니다. 보관기간이 신선도에 많은 영향을 주는 정육식품이기 때문에 수령후 최대한 빠른 시일내에 섭취를 권장드립니다.','15'
,'태우한우 다짐육은 무항생제 1등급 이상의 한우만을 엄선해 풍미 좋고 건강한 고기를 전해요. 기름기가 거의 없는 우둔과 설도만을 사용해 아기들이 소화하는데 부담이 없죠.
가늘게 다져낸 다짐육은 부드러운 결과 식감이 참 곱답니다. 세균 번식을 막아주는 음이온 시설에서 가공되는 점도 컬리의 마음을 끌었죠.1회분씩 소분 포장한 한우 다짐육을 그때그때 꺼내어 간편하게 요리하세요.
우리 아기를 위한 소고기 요리, 태우한우 다짐육과 함께라면 더이상 번거롭지 않아요.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img,weight, explain) 
values(seq_product_table.nextval, '바베큐맛 삼겹살구이 (냉동)', '4900', '1002', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 42, '바베큐맛 삼겹살구이 (냉동).png','320g'
,'라면 끓이듯 간편하게 양념 삼겹살을 만들어보세요. 컬리가 소개하는 돈쉐이크 삼겹살구이는 양념 구이가 얼마나 쉬울 수 있는지 보여줍니다.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img, explain) 
values(seq_product_table.nextval, '베요타 프레사 구이용 200g(냉동)', '18000', '14', '스페인산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 4, 42, '베요타 프레사 구이용 200g(냉동).png','컬리가 준비한 상품입니다.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img, explain) 
values(seq_product_table.nextval, '베요타 플루마 구이용 200g(냉동)', '18500', '10', '스페인산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 42, '베요타 플루마 구이용 200g(냉동).png','컬리가 준비한 상품입니다.');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '세보데깜뽀 플루마 구이용 200g(냉동)', '16500', '10', '스페인산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 4, 42, '세보데깜뽀 플루마 구이용 200g(냉동).png');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '연저육찜', '15000', '6', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 42, '연저육찜.png');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '짭쪼름한맛 삼겹살구이 (냉동)', '4900', '15', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '30', '김진하', '01075653393', 4, 42, '짭쪼름한맛 삼겹살구이 (냉동).png');



-- 닭고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, 'BIG BITE 오키더키 2종', '5900', '10', '국내산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 4, 43,  'BIG BITE 오키더키 2종.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '골든치킨 봉', '7900', '10', '국내산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '골든치킨 봉.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '골든치킨 텐더스틱', '7400', '15', '국내산', '냉동/종이포장', '1팩', '20', '김진하',  '01075653393', 4, 43, '골든치킨 텐더스틱.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '닭가슴살 큐브 스테이크 500g', '7900', '10', '국내산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '닭가슴살 큐브 스테이크 500g.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '닭한마리 칼국수 밀키트', '12000', '4', '국내산', '냉장/종이포장', '1팩', '20', '김진하',  '01075653393', 4, 43, '닭한마리 칼국수 밀키트.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '동물복지 닭가슴살 큐브 스테이크 갈릭500g(냉동)', '7900', '10', '국내산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '동물복지 닭가슴살 큐브 스테이크 갈릭500g(냉동).png' );
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '버팔로 치킨 봉 스파이시', '11000', '10', '국내산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 4, 43, '버팔로 치킨 봉 스파이시.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '사리듬뿍 순살 닭갈비 대용량', '16700', '10', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43 , '사리듬뿍 순살 닭갈비 대용량.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '유기농 치킨 커틀렛 300g', '4900', '15', '국내산', '냉동/종이포장', '1팩', '10', '김진하',  '01075653393', 4, 43, '유기농 치킨 커틀렛 300g.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '초계 닭무침', '4300', '10', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '초계 닭무침.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '춘천식 닭갈비 밀키트', '13000', '11', '국내산', '냉장/종이포장', '1팩', '10', '김진하', '01075653393', 4, 43,  '춘천식 닭갈비 밀키트.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '태양초 닭볶음탕 밀키트', '11000', '15', '국내산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 4, 43,  '태양초 닭볶음탕 밀키트.png');

commit;

-- 수산 생선류
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '고추장굴비 200g(냉동)', '15900', '50', '국산', '냉동/종이포장', '1통', '0', '김진하', '01075653393', 3, 31, '고추장굴비 200g(냉동).png' );
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '동해손질가자미 350g(냉동)', '7900', '10', '국산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 3, 31, '동해손질가자미 350g(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '맘 아픈 굴비 1.4kg(20마리)(냉동)', '26500', '15', '국산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 3, 31,  '맘 아픈 굴비 1.4kg(20마리)(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '민물장어 2마리 450g내외(생물)', '45500', '20', '국산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 31, '민물장어 2마리 450g내외(생물).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '바다장어 2마리 450g내외(생물)', '24900', '10', '국산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 3, 31, '바다장어 2마리 450g내외(생물).png');

commit;

-- 수산 오징어
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '깨끗하게 손질된 오징어 두마리(생물)', '14900', '15', '국내산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 3, 32, '깨끗하게 손질된 오징어 두마리(생물).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '동해안 찜용 오징어 330g(냉동)', '11900', '22', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 32, '동해안 찜용 오징어 330g(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '모리타니산 자숙문어 한마리(냉동)', '27000', '33', '모리타니산', '냉동/종이포장', '1마리', '20', '김진하', '01075653393', 3, 32, '모리타니산 자숙문어 한마리(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '문어 슬라이스 120g(냉장)', '9900', '26', '모리타니산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 32, '문어 슬라이스 120g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '손질 통오징어', '8300', '30', '국산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 3, 32, '손질 통오징어.png');


-- 수산 새우 게
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '갓 잡아올린 신선한 생새우', '18900', '10', '국산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 33,  '갓 잡아올린 신선한 생새우.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '손질 가을수꽃게 6조각(중 300~400g)(냉동)', '14900', '15', '국산', '냉동/종이포장', '1팩', '30', '김진하', '01075653393', 3, 33, '손질 가을수꽃게 6조각(중 300~400g)(냉동).png' );
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '싱싱 흰다리새우(중 220~270g)(냉동)', '10500', '15', '국산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 3, 33, '싱싱 흰다리새우(중 220~270g)(냉동).png');

commit;

-- 채소 기본채소
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '친환경 미니 밤호박 (보짱) 1개', '4300', '10', '국산', '냉장/종이포장', '1개', '0', '김은혜', '01012345678', 1, 11, '친환경 미니 밤호박 (보짱) 1개.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '피클오이(러스보이) 6입', '4300', '10', '국산', '냉장/종이포장', '1팩', '10', '김은혜', '01012345678', 1, 11, '피클오이(러스보이) 6입.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '통마늘 1kg', '7500', '20', '국산', '냉장/종이포장', '1망', '10', '김은혜', '01012345678', 1, 11, '통마늘 1kg.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '초당 옥수수 5입', '10900', '30', '국산', '냉장/종이포장', '1망', '0', '김은혜', '01012345678', 1, 11, '초당 옥수수 5입.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '찰 옥수수 5입 망', '7990', '30', '국산', '냉장/종이포장', '1망', '10', '김은혜', '01012345678', 1, 11, '찰 옥수수 5입 망.jpg');


-- 채소 쌈 샐러드
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[간편 샐러드] 손질 치커리 40g', '1850', '20', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 12, '손질 치커리 40g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[소중한식사] 닭 스프링롤 키트', '8900', '20', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 12, '닭 스프링롤 키트.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[소중한식사] 새우 스프링롤 키트', '8900', '10', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 12, '새우 스프링롤 키트.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[소중한식사] 스프링롤 키트', '7900', '10', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 12, '스프링롤 키트.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '무농약 롤로비온다 80g', '4200', '10', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 12, '무농약 롤로비온다 80g.jpg');


-- 특수채소
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '고수 30g', '1590', '25', '국산', '냉장/종이포장', '1팩','10','김은혜', '01012345678', 1, 13, '고수 30g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '딜 10g', '1590', '16', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 13, '딜 10g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '애플민트 10g', '1450', '17', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 13,'애플민트 10g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '로즈마리 10g', '1400', '10', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 13, '로즈마리 10g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '이탈리안 파슬리 15g', '1350', '18', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 13, '이탈리안 파슬리 15g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '화이트 아스파라거스 200g', '8900', '18', '페루산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 13, '화이트 아스파라거스 200g.jpg');

commit;

---- 과일 견과 국산
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '유기농 블루베리 2종', '4900', '15', '국산', '냉장/종이포장', '1팩','10', '이주명', '01056785678', 2, 21,'유기농 블루베리 2종.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[네떼] 시원할수박에 700g', '8900', '15', '국산', '냉장/종이포장', '1팩','0', '이주명', '01056785678', 2, 21, '시원할수박에 700g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, 'GAP 거봉포도 1팩', '12500', '20', '국산', '냉장/종이포장', '1팩','10', '이주명', '01056785678', 2, 21, 'GAP 거봉포도 1팩.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, 'GAP 천도복숭아 950g', '11950', '20', '국산', '냉장/종이포장', '1팩','0', '이주명', '01056785678', 2, 21, 'GAP 천도복숭아 950g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '고당도 흑미 수박 7kg', '23800', '20', '국산', '냉장/종이포장', '1통', '0','이주명', '01056785678', 2, 21, '고당도 흑미 수박 7kg.jpg');


-- 과일 수입과일
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 그린 파파야 1개', '4400', '15', '필리핀', '냉장/종이포장', '1개', '0','이주명', '01056785678', 2, 22, '그린 파파야 1개.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 스위티오 파인애플 스틱 80g', '1650', '15', '파인애플:필리핀산/제조국:대한민국', '냉장/종이포장', '1봉','0', '이주명', '01056785678', 2, 22, '스위티오 파인애플 스틱 80g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 스위티오 파인애플 슬라이스 540g', '6900', '15', '파인애플:필리핀산/제조국:대한민국', '냉장/종이포장', '1팩','10', '이주명', '01056785678', 2, 22, '스위티오 파인애플 슬라이스 540g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 파파야 1개', '4400', '15', '필리핀', '냉장/종이포장', '1개','0', '이주명', '01056785678', 2, 22, '파파야 1개.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[KF365] 아보카도 1개', '3300', '15', '미국산', '냉장/종이포장', '1개','0', '이주명', '01056785678', 2, 22, '아보카도 1개.jpg');


-- 과일 냉동 건과일
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[델루츠] 소포장 냉동과일 3종', '1980', '15', '제품 별도표기', '냉동/종이포장', '1봉','0', '이주명', '01056785678', 2, 23, '소포장 냉동과일 3종.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[선물세트] 곶감 세트', '75000', '10', '국산', '기타', '1박스','20', '이주명', '01056785678', 2, 23, '곶감 세트.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[아르도] 냉동과일 퓨레1kg 2종', '16500', '15', '제품 별도표기', '냉동/종이포장', '1봉','0', '이주명', '01056785678', 2, 23, '냉동과일 퓨레1kg 2종.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[유가원] 베리베리 믹스 140g', '8800', '10', '제품 별도표기', '냉동/종이포장', '1통','0', '이주명', '01056785678', 2, 23, '베리베리 믹스 140g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[인비바] 과일칩 4종', '3200', '10', '제품 별도표기', '상온/종이포장', '1팩','10', '이주명', '01056785678', 2, 23, '과일칩 4종.jpg');

commit;
     
-- 음료 생수 음료 주스(원산지x)
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[그래미] 여명 808', '8450', '20', '상온/종이포장', '1박스','0', '이주명', '01056785678', 5, 51, '여명 808.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[바로이즙] ABC 착즙주스 2종', '11000', '20', '상온/종이포장', '1박스','10', '이주명', '01056785678', 5, 51, 'ABC 착즙주스 2종.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[산타니올] 스페인 클래식 탄산수 750ml 1박스 (6개입)', '19980', '10', '상온/종이포장', '1박스','0', '이주명', '01056785678', 5, 51, '스페인 클래식 탄산수 750ml 1박스 (6개입).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[산토리니] 스파클링 4종 (묶음)', '11900', '10', '상온/종이포장', '1박스','0', '이주명', '01056785678', 5, 51, '스파클링 4종 (묶음).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[오늘의 일상] 에이드 베이스 4종', '16000', '10', '냉장/종이포장', '1병','0', '이주명', '01056785678', 5, 51, '에이드 베이스 4종.jpg');

-- 음료 커피 차
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[모모스커피] RTD 콜드브루 (에스 쇼콜라)', '4500', '20', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52,'RTD 콜드브루 (에스 쇼콜라).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[모모스커피] RTD 콜드브루 (에티오피아)', '4500', '20', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, 'RTD 콜드브루 (에티오피아).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[모모스커피] RTD 콜드브루 (파나마 펄시 게샤)', '4500', '20', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, 'RTD 콜드브루 (파나마 펄시 게샤).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[연경재] 냉침커피 트로픽가드너(Tropic Gardener)', '4000', '10', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, '냉침커피 트로픽가드너(Tropic Gardener).jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img,best_point)
values(seq_product_table.nextval, '[연경재] 커피원두 젤리빈(Jelly Bean)', '25000', '10', '콜롬비아', '상온/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, '커피원두 젤리빈(Jelly Bean).jpg','20'); -- 원산지 있음
     
-- 음료 우유 두유 요거트
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Kurlys] 동물복지 우유 900ml', '2650', '10', '국내산', '냉장/종이포장', '1팩','0', '이주명', '01056785678', 5, 53, '동물복지 우유 900ml.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[매일] 바이오 플레인 요거트 2종', '2980', '10', '냉장/종이포장', '1통','0', '이주명', '01056785678', 5, 53, '바이오 플레인 요거트 2종.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[매일] 오리지널 우유 1.5L', '3980', '5', '냉장/종이포장', '1통','0', '이주명', '01056785678', 5, 53, '오리지널 우유 1.5L.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[매일] 저지방 우유 1.5L', '3980', '5', '냉장/종이포장', '1통', '10','이주명', '01056785678', 5, 53, '저지방 우유 1.5L.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img, best_point)
values(seq_product_table.nextval, '[베지밀] 건강맘 두유', '14000', '10', '상온/종이포장', '1박스','10', '이주명', '01056785678', 5, 53, '건강맘 두유.jpg','20');

commit;

select * from product_table where product_num = 1;

-- 공지사항 테이블 데이터 추가 --

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'[필독] 고객님, 구매 전 꼭 확인해 주세요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');

insert into notice_table (notice_num, subject, content) 
values(seq_notice_table.nextval,'취소/반품/환불요청은 어떻게 하나요','주문 취소는 제품 배송 전일 오후 6시까지 고객 행복센터(1644-1107)/1:1문의게시판으로 접수 부탁드립니다.
<br>-오후 6시 이후에는 주문 취소가 불가합니다.<br>-고객 행복 센터 운영종료 시간인 오후 4시 이후부터는 1:1문의 게시판 접수만 가능합니다.');
commit;

-- 자주하는 질문 테이블 데이터 추가 --
desc FAQ_table;
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '아이디와 비밀번호가 생각나지 않아요. 어떻게 찾을 수 있나요?',
'(PC)오른쪽 위의 [로그인] > 화면 아래[아이디 찾기][비밀번호 찾기]<br>를 통해 확인이 가능하며,
임시 비밀번호의 경우 회원가입시 등록하신 메일로 발송됩니다.<br>
가입시 기재한 메일 주소가 기억나지 않으시거나 오류가 발생한 경우,<br>
고객행복센터(1644-1107)로 문의 주시면 신속하게 도움 드리겠습니다.', 1);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '회원가입은 무료인가요?',
'컬리는 배송지역 상관없이 회원가입은 무료입니다. <br>
회원가입 후 다양한 혜택과 상품을 만나보세요', 1);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '아이디와 비밀번호가 생각나지 않아요. 어떻게 찾을 수 있나요?',
'(PC)오른쪽 위의 [로그인] > 화면 아래[아이디 찾기][비밀번호 찾기]<br>를 통해 확인이 가능하며,
임시 비밀번호의 경우 회원가입시 등록하신 메일로 발송됩니다.<br>
가입시 기재한 메일 주소가 기억나지 않으시거나 오류가 발생한 경우,<br>
고객행복센터(1644-1107)로 문의 주시면 신속하게 도움 드리겠습니다.', 1);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '회원가입은 무료인가요?',
'컬리는 배송지역 상관없이 회원가입은 무료입니다. <br>
회원가입 후 다양한 혜택과 상품을 만나보세요', 1);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '아이디와 비밀번호가 생각나지 않아요. 어떻게 찾을 수 있나요?',
'(PC)오른쪽 위의 [로그인] > 화면 아래[아이디 찾기][비밀번호 찾기]<br>를 통해 확인이 가능하며,
임시 비밀번호의 경우 회원가입시 등록하신 메일로 발송됩니다.<br>
가입시 기재한 메일 주소가 기억나지 않으시거나 오류가 발생한 경우,<br>
고객행복센터(1644-1107)로 문의 주시면 신속하게 도움 드리겠습니다.', 1);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '회원가입은 무료인가요?',
'컬리는 배송지역 상관없이 회원가입은 무료입니다. <br>
회원가입 후 다양한 혜택과 상품을 만나보세요', 1);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '전화로도 주문할 수 있나요?',
'현재 전화주문이 불가합니다.(오프라인 매장 보유X)<br>
모든 주문은 온라인으로 가능하오니 인터넷으로 접속하셔서 원하시는 상품을 주문하세요!!', 2);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '현금영수증 발행을 취소하고 싶어요',
'고객의 요청에 의해 발급된 현금영수증은 국세청 승인 후에는 변경 불가합니다.<br>
국세청 승인 전이라면 1:1문의 또는 고객센터로 문의 바랍니다.', 2);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '전화로도 주문할 수 있나요?',
'현재 전화주문이 불가합니다.(오프라인 매장 보유X)<br>
모든 주문은 온라인으로 가능하오니 인터넷으로 접속하셔서 원하시는 상품을 주문하세요!!', 2);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '현금영수증 발행을 취소하고 싶어요',
'고객의 요청에 의해 발급된 현금영수증은 국세청 승인 후에는 변경 불가합니다.<br>
국세청 승인 전이라면 1:1문의 또는 고객센터로 문의 바랍니다.', 2);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '전화로도 주문할 수 있나요?',
'현재 전화주문이 불가합니다.(오프라인 매장 보유X)<br>
모든 주문은 온라인으로 가능하오니 인터넷으로 접속하셔서 원하시는 상품을 주문하세요!!', 2);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '현금영수증 발행을 취소하고 싶어요',
'고객의 요청에 의해 발급된 현금영수증은 국세청 승인 후에는 변경 불가합니다.<br>
국세청 승인 전이라면 1:1문의 또는 고객센터로 문의 바랍니다.', 2);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '전화로도 주문할 수 있나요?',
'현재 전화주문이 불가합니다.(오프라인 매장 보유X)<br>
모든 주문은 온라인으로 가능하오니 인터넷으로 접속하셔서 원하시는 상품을 주문하세요!!', 2);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '현금영수증 발행을 취소하고 싶어요',
'고객의 요청에 의해 발급된 현금영수증은 국세청 승인 후에는 변경 불가합니다.<br>
국세청 승인 전이라면 1:1문의 또는 고객센터로 문의 바랍니다.', 2);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '전화로도 주문할 수 있나요?',
'현재 전화주문이 불가합니다.(오프라인 매장 보유X)<br>
모든 주문은 온라인으로 가능하오니 인터넷으로 접속하셔서 원하시는 상품을 주문하세요!!', 2);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '현금영수증 발행을 취소하고 싶어요',
'고객의 요청에 의해 발급된 현금영수증은 국세청 승인 후에는 변경 불가합니다.<br>
국세청 승인 전이라면 1:1문의 또는 고객센터로 문의 바랍니다.', 2);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송 가능 지역인지 어떻게 확인하나요',
'배송은 국내에 한해서 전 지역 다 됩니다.', 3);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송완료 알림톡 또는 문자는 언제 오나요?',
'배송완료 알림톡 또는 문자는 고객님께서 주문서에 기입하신 옵션대로 배송 직후 또는 아침 7시에 전송됩니다.', 3);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송 가능 지역인지 어떻게 확인하나요',
'배송은 국내에 한해서 전 지역 다 됩니다.', 3);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송완료 알림톡 또는 문자는 언제 오나요?',
'배송완료 알림톡 또는 문자는 고객님께서 주문서에 기입하신 옵션대로 배송 직후 또는 아침 7시에 전송됩니다.', 3);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송 가능 지역인지 어떻게 확인하나요',
'배송은 국내에 한해서 전 지역 다 됩니다.', 3);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송완료 알림톡 또는 문자는 언제 오나요?',
'배송완료 알림톡 또는 문자는 고객님께서 주문서에 기입하신 옵션대로 배송 직후 또는 아침 7시에 전송됩니다.', 3);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송 가능 지역인지 어떻게 확인하나요',
'배송은 국내에 한해서 전 지역 다 됩니다.', 3);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송완료 알림톡 또는 문자는 언제 오나요?',
'배송완료 알림톡 또는 문자는 고객님께서 주문서에 기입하신 옵션대로 배송 직후 또는 아침 7시에 전송됩니다.', 3);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송 가능 지역인지 어떻게 확인하나요',
'배송은 국내에 한해서 전 지역 다 됩니다.', 3);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송완료 알림톡 또는 문자는 언제 오나요?',
'배송완료 알림톡 또는 문자는 고객님께서 주문서에 기입하신 옵션대로 배송 직후 또는 아침 7시에 전송됩니다.', 3);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송 가능 지역인지 어떻게 확인하나요',
'배송은 국내에 한해서 전 지역 다 됩니다.', 3);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '배송완료 알림톡 또는 문자는 언제 오나요?',
'배송완료 알림톡 또는 문자는 고객님께서 주문서에 기입하신 옵션대로 배송 직후 또는 아침 7시에 전송됩니다.', 3);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '팝업이 안 보여요',
'고객님께 유용하고 중요한 정보를 팝업으로 안내드리고 있습니다.<br>
팝업차단을 해제하면 더 많은 좋은 쇼핑기회를 얻을 수 있습니다.<br>
해결방법<br>
(1)팝업창이 나오지 않을 경우, 주소입력(URL)단 밑에 노란 표시줄을 더블 클릭<br>
(2)안내창 더블클릭 > 현재사이트의 팝업을 항상 허용', 4);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '상품문의 어떻게 하나요?',
'상품문의는 상품상세 > 상품문의 <br>
에 남겨주시면 영업일 기준 1~2일 내에 답변드립니다.', 4);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '팝업이 안 보여요',
'고객님께 유용하고 중요한 정보를 팝업으로 안내드리고 있습니다.<br>
팝업차단을 해제하면 더 많은 좋은 쇼핑기회를 얻을 수 있습니다.<br>
해결방법<br>
(1)팝업창이 나오지 않을 경우, 주소입력(URL)단 밑에 노란 표시줄을 더블 클릭<br>
(2)안내창 더블클릭 > 현재사이트의 팝업을 항상 허용', 4);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '상품문의 어떻게 하나요?',
'상품문의는 상품상세 > 상품문의 <br>
에 남겨주시면 영업일 기준 1~2일 내에 답변드립니다.', 4);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '팝업이 안 보여요',
'고객님께 유용하고 중요한 정보를 팝업으로 안내드리고 있습니다.<br>
팝업차단을 해제하면 더 많은 좋은 쇼핑기회를 얻을 수 있습니다.<br>
해결방법<br>
(1)팝업창이 나오지 않을 경우, 주소입력(URL)단 밑에 노란 표시줄을 더블 클릭<br>
(2)안내창 더블클릭 > 현재사이트의 팝업을 항상 허용', 4);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '상품문의 어떻게 하나요?',
'상품문의는 상품상세 > 상품문의 <br>
에 남겨주시면 영업일 기준 1~2일 내에 답변드립니다.', 4);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '팝업이 안 보여요',
'고객님께 유용하고 중요한 정보를 팝업으로 안내드리고 있습니다.<br>
팝업차단을 해제하면 더 많은 좋은 쇼핑기회를 얻을 수 있습니다.<br>
해결방법<br>
(1)팝업창이 나오지 않을 경우, 주소입력(URL)단 밑에 노란 표시줄을 더블 클릭<br>
(2)안내창 더블클릭 > 현재사이트의 팝업을 항상 허용', 4);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '상품문의 어떻게 하나요?',
'상품문의는 상품상세 > 상품문의 <br>
에 남겨주시면 영업일 기준 1~2일 내에 답변드립니다.', 4);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '팝업이 안 보여요',
'고객님께 유용하고 중요한 정보를 팝업으로 안내드리고 있습니다.<br>
팝업차단을 해제하면 더 많은 좋은 쇼핑기회를 얻을 수 있습니다.<br>
해결방법<br>
(1)팝업창이 나오지 않을 경우, 주소입력(URL)단 밑에 노란 표시줄을 더블 클릭<br>
(2)안내창 더블클릭 > 현재사이트의 팝업을 항상 허용', 4);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '상품문의 어떻게 하나요?',
'상품문의는 상품상세 > 상품문의 <br>
에 남겨주시면 영업일 기준 1~2일 내에 답변드립니다.', 4);

insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '팝업이 안 보여요',
'고객님께 유용하고 중요한 정보를 팝업으로 안내드리고 있습니다.<br>
팝업차단을 해제하면 더 많은 좋은 쇼핑기회를 얻을 수 있습니다.<br>
해결방법<br>
(1)팝업창이 나오지 않을 경우, 주소입력(URL)단 밑에 노란 표시줄을 더블 클릭<br>
(2)안내창 더블클릭 > 현재사이트의 팝업을 항상 허용', 4);
insert into FAQ_table (faq_num, subject, content, fk_category_num)
values(seq_FAQ_table.nextval, '상품문의 어떻게 하나요?',
'상품문의는 상품상세 > 상품문의 <br>
에 남겨주시면 영업일 기준 1~2일 내에 답변드립니다.', 4);

-- 상품 문의 게시글 데이터 추가 --
desc product_inquiry_table;
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);

insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,1);



insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);
insert into product_inquiry_table(inquiry_num, subject, content, fk_member_num, fk_product_num)
values(seq_product_inquiry.nextval, '상품이 없어요','안녕하세요, 상품이 없어요, 어떻게 된거에요',2,2);

commit;

-- 주문내역 데이터 추가 --
desc order_table;
/*
ORDER_NUM               NOT NULL NUMBER        
ORDER_DATE                       DATE          
RECIPIENT               NOT NULL VARCHAR2(50)  
RECIPIENT_MOBILE        NOT NULL VARCHAR2(100) 
RECIPIENT_POSTCODE      NOT NULL VARCHAR2(100) 
RECIPIENT_ADDRESS       NOT NULL VARCHAR2(200) 
RECIPIENT_DETAILADDRESS NOT NULL VARCHAR2(200) 
PRICE                   NOT NULL NUMBER        
MEMO                             VARCHAR2(200) 
FK_MEMBER_NUM                    NUMBER        
FK_CATEGORY_NUM         NOT NULL NUMBER  
*/

alter table order_table modify RECIPIENT_DETAILADDRESS varchar2(200) null;

select * from order_table;
select * from order_product_table;

insert into order_table(order_num, recipient, recipient_mobile, recipient_postcode, recipient_address, recipient_detailaddress, price, fk_member_num, fk_category_num)
values(seq_order_table.nextval, '이주명', '01091018698' , '21519','인천 남동구 서판로 30(만수동, 대성유니드 별빛마을 아파트)','103동 1701호', 12600,2,0);
insert into order_product_table(product_count, fk_order_num, fk_product_num, price)
values(3,2,90,3000);


update order_table set order_date = sysdate-30 where order_num > 2;
update order_table set order_date = sysdate-60 where order_num > 7;
update order_table set order_date = sysdate-90 where order_num > 10;
update order_table set order_date = sysdate-120 where order_num > 19;
update order_table set order_date = sysdate-141 where order_num > 23;
commit;

select product_num, product_name, stock from product_table where fk_category_num=3;