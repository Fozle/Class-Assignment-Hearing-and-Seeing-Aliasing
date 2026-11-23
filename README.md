## Questions and Answers

**1. Which sampling frequencies represented the 7 kHz signal correctly?**

The 24 kHz and 16 kHz sampling frequencies represented the 7 kHz signal correctly because both are above the Nyquist rate of 14 kHz.

**2. When did the 7 kHz signal appear as another frequency?**

At 12 kHz, it appeared as 5 kHz. At 8 kHz, it appeared as 1 kHz.

**3. What happened when the Nyquist frequency became lower than 7 kHz?**

Aliasing occurred. The original 7 kHz signal appeared at a lower frequency in the spectrum.

**4. Did the aliased signal sound different?**

Yes. The aliased signals sounded different because their apparent frequencies changed.

**5. Why can MATLAB not recover the original 7 kHz signal after aliasing?**

After aliasing, different original frequencies can produce the same sampled data. Therefore, MATLAB cannot identify the original frequency from those samples alone.
