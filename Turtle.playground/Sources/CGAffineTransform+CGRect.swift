//
//  CGAffineTransform+CGRect.swift
//

import QuartzCore


extension CGAffineTransform
{

    public static func fit(rect src: CGRect, in dst: CGRect) -> CGAffineTransform
    {
        func aspect(_ size : CGSize) -> CGFloat
        {
            return size.width / size.height
        }

        func scaleToFit(_ src : CGSize, in dst : CGSize) -> CGFloat
        {
            return aspect(dst) >= aspect(src) ? (dst.height / src.height) : (dst.width / src.width)
        }

        let scale = scaleToFit(src.size, in: dst.size);

        return CGAffineTransform(a: scale, b: 0,
                                 c: 0, d: scale,
                                 tx: dst.midX - src.midX * scale,
                                 ty: dst.midY - src.midY * scale)
    }
}
