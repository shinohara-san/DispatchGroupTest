//
//  ViewController.swift
//  DispatchGroupTest
//
//  Created by Yuki Shinohara on 2020/07/08.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numbers: [TimeInterval] = [
        1,
        7,
        3,
        5,
        2
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        let group = DispatchGroup() //非同期処理をグループとして扱う
        
        for num in numbers {
            group.enter() //非同期処理の実行前にenter()
            print("Entering group with number: \(num)") //forなので配列の順番通り
            DispatchQueue.global().asyncAfter(deadline: .now() + num) {
                group.leave() //実行後にleave() => 複数の非同期処理の開始と完了を管理。
                //全部終わったときにnotify()が発動
                print("Leaving group for: \(num)") //配列順とは限らない
            }
        }
        
        group.notify(queue: .main) {
//全ての処理で完了の合図としてleave()が呼ばれた後に、notify()メソッドで指定したクロージャが実行されます
            print("All work done")
            self.view.backgroundColor = .systemGreen
        }
    }


}

//https://qiita.com/shtnkgm/items/d9b78365a12b08d5bde1

//GCD（Grand Central Dispatch）のDispatchGroupを作成し、非同期処理の実行前にenter()、実行後にleave()を呼ぶことで、複数の非同期処理の開始と完了を管理します。
//全ての処理で完了の合図としてleave()が呼ばれた後に、notify()メソッドで指定したクロージャが実行されます。
