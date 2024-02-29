//
//  ContentView.swift
//  TagView
//
//  Created by daryl on 29/2/24.
//

import SwiftUI

struct ContentView: View {
   
   @State private var tags: [String] = ["My", "name", "is", "Michael", "School", "Park", "Tomorrow", "How"]
   
   @State private var selectedTags: [String] = []
   
   @Namespace private var animation
   
    var body: some View {
       VStack(spacing: 0) {
          VStack {
             Text("My name is Michael")
             TagLayout(alignment: .leading, spacing: 10) {
                ForEach(selectedTags, id:\.self) { tag in
                   TagView(tag, .pink, "")
                      .matchedGeometryEffect(id: tag, in: animation)
                      .onTapGesture {
                         withAnimation(.snappy) {
                            selectedTags.removeAll(where: {$0 == tag})
                         }
                      }
                }
             }
             .padding(.horizontal, 15)
             .padding(.vertical)
             .padding(.bottom, 24)
             .overlay {
             if selectedTags.isEmpty {
                Text("Select more than 3 tags")
                   .font(.callout)
                   .foregroundStyle(.gray)
               }
             }
             Spacer()
                .frame(height: 320)
          }
          .background(.white)
             TagLayout(alignment: .leading, spacing: 10) {
                ForEach(tags.filter { !selectedTags.contains($0)}, id: \.self) { tag in
                   TagView(tag, .blue, "plus")
                      .matchedGeometryEffect(id: tag, in: animation)
                      .onTapGesture {
                         withAnimation(.snappy) {
                            selectedTags.append(tag)
                         }
                      }
                }
             }
             .padding(15)

          .background(.black.opacity(0.05))
          
          ZStack {
             Button(action: {}) {
                Text("Continue")
                   .fontWeight(.semibold)
                   .padding(.vertical, 15)
                   .frame(maxWidth: .infinity)
                   .foregroundStyle(.white)
                   .background {
                      RoundedRectangle(cornerRadius: 12)
                         .fill(.pink.gradient)
                   }
             }
             .disabled(selectedTags.count < 3)
             .opacity(selectedTags.count < 3 ? 0.5 : 1)
             .padding()
          }
          .background(.white)
          
        }
       .preferredColorScheme(.light)
    }
   
   @ViewBuilder
   func TagView(_ tag: String, _ color: Color, _ icon: String) -> some View {
      HStack(spacing: 10) {
         Text(tag)
            .font(.callout)
            .fontWeight(.semibold)
         
         
            icon != "" ? Image(systemName: icon) : nil
         
         
      }
      .frame(height: 35)
      .foregroundStyle(.white)
      .padding(.horizontal, 15)
      .background {
         Capsule()
            .fill(color.gradient)
      }
   }
 
   
   
}

#Preview {
    ContentView()
}
