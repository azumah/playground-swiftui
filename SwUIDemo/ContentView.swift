//
//  ContentView.swift
//  SwUIDemo
//
//  Created by Azu on 12/07/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var presenter: ListPresenter
    @State private var toggleStatus = true
    
    var body: some View {
        NavigationView {
            List{
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notification")
                    }
                }
                
                Section(header: Text("To do list")){
                    ForEach(presenter.listData){ item in
                        NavigationLink(destination: Text(item.task)){
                            Label(item.task, systemImage: item.imageName)
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    // Intents
    func deleteItem(at offsets: IndexSet) {
        presenter.deleteItem(at: offsets)
    }
    
    func moveItem(from indices: IndexSet, newOffset: Int) {
        presenter.moveItem(from: indices, destination: newOffset)
    }
}


struct CrossStackAlignmentDemo: View {
    var body: some View {
        HStack(alignment: .crossAlignment, spacing: 20){
            Circle()
                .foregroundColor(.purple)
                .alignmentGuide(.crossAlignment) { d in d[VerticalAlignment.center] }
                .frame(width: 100, height: 100)
            
            VStack(alignment: .center){
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .foregroundColor(.red)
                    .alignmentGuide(.crossAlignment) { d in d[VerticalAlignment.center] }
                    .frame(width: 100, height: 100)
                Rectangle()
                    .foregroundColor(.blue)
                    
                    .frame(width: 100, height: 100)
                Rectangle()
                    .foregroundColor(.orange)
                    
                    .frame(width: 100, height: 100)
            }
        }
    }
    
    
}

struct OneThirdHStackView: View {
    var body: some View {
        
        HStack(alignment: .oneThird) {
            Rectangle()
                .foregroundColor(.green)
                .frame(width: 50, height: 200)
            Rectangle()
                .foregroundColor(.red)
                .alignmentGuide(.oneThird, computeValue: { dimension in
                    dimension[VerticalAlignment.bottom]
                })
                .frame(width: 50, height: 200)
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 50, height: 200)
            Rectangle()
                .foregroundColor(.orange)
                .alignmentGuide(.oneThird, computeValue: { dimension in
                    dimension[VerticalAlignment.top]
                })
                .frame(width: 50, height: 200)
        }
    }
}

extension VerticalAlignment {
    private enum OneThird: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context.height * 0.3
        }
    }
    
    static let oneThird = VerticalAlignment(OneThird.self)
    
}

extension VerticalAlignment {
    private enum CrossAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.bottom]
        }
    }
    
    static let crossAlignment = VerticalAlignment(CrossAlignment.self)
}

struct ContentView_Previews: PreviewProvider {
    
    static let listManager = ListPresenter()
    
    static var previews: some View {
        Group {
            ContentView(presenter: listManager)
            ContentView(presenter: listManager).preferredColorScheme(.dark)
        }
    }
}

