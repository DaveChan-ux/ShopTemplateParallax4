//
//  ContentView.swift
//  Parallax w/ inverse controls, but with flattened background image
//
//  Created by Dave.Chan on 1/14/25.
//

import SwiftUI
import CoreMotion

struct ParallaxMotionModifier: ViewModifier {

    var pitch: Double
    var roll: Double
    var magnitude: Double

    func body(content: Content) -> some View {
        content
            .offset(x: CGFloat(roll * magnitude), y: CGFloat(pitch * magnitude))
    }
}

struct InverseParallaxMotionModifier: ViewModifier {

    var pitch: Double
    var roll: Double
    var magnitude: Double

    func body(content: Content) -> some View {
        content
            .offset(x: CGFloat(-roll * magnitude), y: CGFloat(-pitch * magnitude))
    }
}

struct ContentView: View {
    @State var pitch: Double = 0.0
    @State var roll: Double = 0.0
    @State var yaw: Double = 0.0

    let manager = CMMotionManager()

    var body: some View {

        VStack(spacing:24) {

            HStack{ //copy link text

                Text("Copy link or share a preview of your LTK on social to begin growing your audience. ")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .lineSpacing(8)
                    .foregroundColor(Color(red: 0.94, green: 0.95, blue: 0.96))
                }
                .frame(maxWidth: .infinity)

// ----------------------------------------------------

            HStack{  //BUTTON CTA

                Image(systemName: "link")
                    .foregroundColor(.black)
                Text("Copy my LTK link")
                    .font(.system(size: 14, weight: .bold))
                    .lineSpacing(20)
                    .foregroundColor(Color(red: 0.06, green: 0.07, blue: 0.09))
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .background(.white)
            .cornerRadius(100)

// ----------------------------------------------------

            HStack { //Divider and Text and Divider

                    HStack{ //Divider
                        Rectangle()
                          .frame(maxWidth: .infinity, maxHeight: 1)
                          .overlay(
                            Rectangle()
                            .stroke(Color(red: 0.76, green: 0.76, blue: 0.78), lineWidth: 0.50)
                            )
                            }

                    HStack {
                        //OR
                        Text("Or")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.white))
                            }
                            .frame(width: 33.76, height: 22)

                    HStack{ //Divider
                        Rectangle()
                          .frame(maxWidth: .infinity, maxHeight: 1)
                          .overlay(
                            Rectangle()
                            .stroke(Color(red: 0.76, green: 0.76, blue: 0.78), lineWidth: 0.50)
                            )
                            }
                }

// ----------------------------------------------------

            ZStack {
                Image("ShopTemplateFlatNoText") //blur
                    .resizable()
                    .frame(width: 265, height: 471)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .blur(radius: 40)
                    .scaleEffect(0.9)
                    .offset(y: 40)
                    .modifier(ParallaxMotionModifier(pitch: pitch, roll: roll, magnitude: 10))
                    .animation(.interactiveSpring(), value: pitch)
                    .animation(.interactiveSpring(), value: roll)
                
                Image("ShopTemplateFlatNoText") //image
                    .resizable()
                    .frame(width: 265, height: 471)
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .blur(radius: 16)
                    .scaleEffect(0.9)
                    .offset(y: 12)
                    .modifier(ParallaxMotionModifier(pitch: pitch, roll: roll, magnitude: 5))
                    .saturation(2.0)
                    .animation(.interactiveSpring(), value: pitch)
                    .animation(.interactiveSpring(), value: roll)


                Image("ShopTemplateFlatNoText") //inversed
                    .resizable()
                    .frame(width: 265, height: 471)
                    .scaleEffect(1.2)
                //                .scaleEffect(1)
                    .modifier(InverseParallaxMotionModifier(pitch: pitch, roll: roll, magnitude: 30))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .modifier(ParallaxMotionModifier(pitch: pitch, roll: roll, magnitude: 50))
                    .animation(.interactiveSpring(), value: pitch)
                    .animation(.interactiveSpring(), value: roll)

                // ----------------------------------------------------

                    VStack { //Overlay text + profile image //IMAGE 3 - inversed
                        Image("avb")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(.circle)
                            .overlay(
                                Circle()
                                    .stroke(Color(red: 255, green: 255, blue: 255), lineWidth: 1)
                            )
                            .padding(.top, 92)

                    VStack { //H1 text
                            Text("Follow me on LTK")
                                .font(.system(size: 24, weight: .bold))
                                .lineSpacing(20)
                                .foregroundColor(Color(.white))
                                .padding(.bottom, 10)

                            VStack{ //body text
                                    Text("Download the free LTK app to..\n • Be the first to shop my posts \n • Find all my favorite products \n • Access exclusive content")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 12, weight: .regular))
                                        .lineSpacing(8)
                                        .foregroundColor(Color(.white))
                                        }
                            }

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                    .background(Color.red)




                // ----------------------------------------------------

            }.preferredColorScheme(.light)
                .onAppear {
                    manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
                        pitch = motionData!.attitude.pitch
                        roll = motionData!.attitude.roll
                        yaw = motionData!.attitude.yaw
                    }
                }
                .frame(width: 265, height: 471) 
//                .background(Color.red)

            // ----------------------------------------------------


            HStack { //Share preview button
                //BUTTON CTA
                HStack{
                    Text("Share this preview")
                        .font(.system(size: 14, weight: .bold))
                        .lineSpacing(20)
                        .foregroundColor(Color.white)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .background(Color(red:0.11, green: 0.11, blue: 0.15))
            .cornerRadius(100)
            .overlay(RoundedRectangle(cornerRadius: 100)
                    .stroke(.white, lineWidth: 1))
        }
        .frame(maxHeight: .infinity)
        .padding(EdgeInsets(top: 24, leading: 32, bottom: 24, trailing: 32))
        .background(Color(red:0.11, green: 0.11, blue: 0.15))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
