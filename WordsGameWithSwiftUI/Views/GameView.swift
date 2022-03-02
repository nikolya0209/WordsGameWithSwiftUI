//
//  GameView.swift
//  WordsGameWithSwiftUI
//
//  Created by MacBookPro on 28.02.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    @State private var confirmPresent = false
    @State private var isAlertPresented = false
    @State var alertText = ""
    var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16, content: {
            HStack {
                Button(action: {
                    confirmPresent.toggle()
                }, label: {
                    Text("Выход")
                        .padding(6)
                        .padding(.horizontal)
                        .background(Color("Orange"))
                        .cornerRadius(12)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                })
                Spacer()
            }
            Text("\(viewModel.word)")
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.white)
            HStack(spacing: 12) {
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.player1.name)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                .background(Color("FirstPlayer"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirst ? .red : .clear, radius: 4, x: 0, y: 0)
                
                VStack {
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.player2.name)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                .background(Color("SecondColor"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirst ? .clear : .purple, radius: 4, x: 0, y: 0)
            }
            WordTextField(word: $word, placeHolder: "Bаше слово")
            .padding(.horizontal)
            
            Button(action: {
                
                var score = 0
                
                do {
                    try score = viewModel.check(word: word)
                    
                } catch WordError.beforeWord {
                    alertText = "Придумай словоб которое не было составлено ранее"
                    isAlertPresented.toggle()
                    
                } catch WordError.littleWord {
                    alertText = "Cлишком короткое слово"
                    isAlertPresented.toggle()
                } catch WordError.theSameWord {
                    alertText = "Вставленное словов не должно быть исходным словом"
                    isAlertPresented.toggle()
                } catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составлено"
                    isAlertPresented.toggle()
                } catch {
                    alertText = "Неизвестная ошибка"
                    isAlertPresented.toggle()
                }
                
                if score > 1 {
                    self.word = ""
                }
               
            }, label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Orange"))
                    .cornerRadius(12)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .padding(.horizontal)
            })
            
            List {
                
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondColor"))
                        .listRowInsets(EdgeInsets())
                        
                }
                
            }.padding(6)
            .listStyle(PlainListStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }).background(Image("iPhone-11-Black"))
            .confirmationDialog("Вы уверены что хотите завершить игру",
                                isPresented: $confirmPresent, titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                
                Button(role: .cancel) {
                } label: {
                    Text("Heт")
                }

            }
                                .alert(alertText, isPresented: $isAlertPresented) {
                                    Text("OK!")
                                }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Вася"), player2: Player(name: "Петя"), word: "Магнит"))
    }
}
