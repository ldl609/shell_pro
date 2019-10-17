--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
									grep指令										        sed指令											   awk指令	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
正则表达式元字符含义		  元字符					示例					     元字符						示例					  元字符						示例
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1.行首定位符					^			grep ^num test.sh					^			sed -n  '/^num/p' test.sh 			^			awk '/^num/{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
2.行尾定位符					$			grep fi$ test.sh					$			sed -n  '/fi$/p' test.sh			$			awk '/num$/{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
3.匹配除换行外的单个字符		.			grep 'e.' test.sh					.			sed -n  '/e./p' test.sh				.			awk '/e../{print $0}' test.sh
										grep 'e\..' test.sh								sed -n  '/e\../p' test.sh						awk '/e\../{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------								
4.匹配零个或多个前导字符		*			grep 's*ll ' test.sh				*			无									*			awk '/s*ll/{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
5.匹配指定字符组内任意字符		[]			grep '[ef]' test.sh					[]			sed -n '/[ef]/p' test.sh			[]			awk '/[ef]/{print $0}' test.sh
										grep '[we]tern' test.sh							sed -n '/[a-z][0-9]/p' test.sh					awk '/[we]tern/{print $0}' test.sh
										grep '[a-z][0-9]' test.sh 						sed -n '/[we]tern/p' test.sh					awk '/[a-z][0-9]/{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
6.匹配不在指定字符组			[^]			grep '[^ef]' test.sh				[^]			sed -n '/[^ef]/p' test.sh			[^]			awk '/[^ef]/{print $0}' test.sh
内的任意字符								grep '[^0-9]' test.sh							sed -n '/[^0-9]/p' test.sh						awk '/[^0-9]/{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
7.保存已匹配的字符			\(..\)		grep  '\(3\)\.[0-9].*\1' test.sh	\(..\)		无									无			无
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
8.存查找串以便在替换串中引用	&			无									&			sed  's/num/**&**/' test.sh 		&			无
'\1'表示使用保存匹配到的值	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
9.词首定位符					\<			grep '\<nu' test.sh					\<			sed -n '/\<nu/p' test.sh 			无			无
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
10.词尾定位					\>			grep 'nu\>' test.sh					\>			sed -n '/nu\>/p' test.sh 			无			无
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
11.连续m个x 					X\{m\}		grep 'f\{5\}' test.sh				X\{m\}		sed -n '/f\{5\}/p' test.sh			X{m}		awk '/f{5}/' test.sh
										grep '[a-z]\{9\}'  test.sh						sed -n '/[a-z]\{9\}/p' test.sh					awk '/[a-z]{9}/' test.sh
										grep '[0-9]\{6\}'	test.sh 					sed -n '/[0-9]\{6\}/p' test.sh					awk '/[0-9]{6}/' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
12.至少连续m个x 				X\{m,\}		grep 'g\{6,\}' test.sh				X\{m,\}		sed -n '/g\{6,\}/p' test.sh			X{m,}		awk '/f{5,}/' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
13.至少连续m个x,但不超过n		X\{m,n\}	grep 'g\{6,10\}' test.sh			X\{m,n\}	sed -n '/g\{6,10\}/p' test.sh		X{m,n}		awk '/f{5,10}/' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
14.匹配一个或多个前导字符		+			egrep '[a-z]+ove' test.sh			无			无									+			awk '/s+h/{print $0}' test.sh
										grep -E  '[a-z]+ove' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
15.匹配0个或一个前导字符		?			egrep '[a-z]?oo' test.sh			无			无									?			awk '/f?n/{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
16.子表达式组合				()			无									无			无									()			无
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
17.匹配a或者b				|			agrep "west|north" test.sh			无			无									|			awk '/fi|if/{print $0}' test.sh
										grep -E "west|north" test.sh			
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
18.转义字符					无			无									无			无									\			awk '/a\/\//{print $0}' test.sh
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
19.匹配,不匹配条件语句		无			无									无			无									~,!~		无	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------








						
						
