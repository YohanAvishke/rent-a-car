//
//  ContactUsView.swift
//  RentACar
//
//  Created by Gavin Li on 5/8/2025.
//

import SwiftUI

struct ContactUsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var subject = ""
    @State private var message = ""
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("联系内容")) {
                    TextField("主题", text: $subject)
                    
                    ZStack(alignment: .topLeading) {
                        if message.isEmpty {
                            Text("请输入您的问题或反馈...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $message)
                            .frame(minHeight: 150)
                            .opacity(message.isEmpty ? 0.25 : 1)
                    }
                }
                
                Section {
                    Button("提交") {
                        // 提交逻辑
                        showSuccessAlert = true
                    }
                    .foregroundColor(.blue)
                }
                
                Section(header: Text("其他联系方式")) {
                    HStack {
                        Image(systemName: "envelope")
                        Text("support@rentacar.com")
                    }
                    
                    HStack {
                        Image(systemName: "phone")
                        Text("+86 123 4567 8910")
                    }
                }
            }
            .navigationTitle("联系我们")
            .navigationBarItems(trailing: Button("关闭") {
                dismiss()
            })
            .alert("提交成功", isPresented: $showSuccessAlert) {
                Button("确定", role: .none) {
                    dismiss()
                }
            } message: {
                Text("我们会尽快回复您的消息")
            }
        }
    }
}

#Preview {
    ContactUsView()
}
